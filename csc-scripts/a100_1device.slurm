#!/bin/bash
#SBATCH --job-name=a100_g1b6
#SBATCH --account=dac
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --mem=80G
#SBATCH --partition=gputest
#SBATCH --gres=gpu:a100:1
#SBATCH --time=00:15:00

#SBATCH --output=logs/%x-%j.out

module purge
module use /appl/local/csc/modulefiles
module load pytorch

source setup-csc.sh
source /scratch/dac/shanshan/.venv/bin/activate
set -xv
tune run \
    lora_finetune_single_device \
    --config ../configs/1B_lora_single_device.yaml \
    max_steps_per_epoch=$MAX_STEPS \
    checkpointer.checkpoint_dir=$MODEL_DIR \
    tokenizer.path=$MODEL_DIR/original/tokenizer.model \
    output_dir=$OUTPUT_DIR \
    metric_logger.log_dir=$OUTPUT_DIR \
    metric_logger.name=$WANDB_NAME \
    metric_logger.id=$WANDB_NAME \
    batch_size=$BATCH_SIZE
