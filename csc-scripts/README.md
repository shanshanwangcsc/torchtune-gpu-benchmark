# torchtune-gpu-benchmark
Code for running gpu benchmarks with torchtune on mahti

### Setup

1. Create a virtual environment:

```
module purge
module use /appl/local/csc/modulefiles
module load pytorch/2.7
python3 -m venv --system-site-packages .venv
source .venv/bin/activate
pip install torchtune
pip install wandb
pip install huggingface_hub
```

2. Download Llama to the desired location:

```
tune download meta-llama/Llama-3.2-1B-Instruct --output-dir <output_dir> --hf-token <hf-token>
```

By default, setup-csc.sh is suggesting "/scratch/dac/${USER}/torchtune_models/Llama-3.2-1B-Instruct" so I'd stick with that. Change dac to your own project number.

```
export MODEL_DIR="/scratch/dac/${USER}/torchtune_models/Llama-3.2-1B-Instruct" #change dac to your own project account number
huggingface-cli login #put your token
huggingface-cli download meta-llama/Llama-3.2-1B-Instruct --local-dir $MODEL_DIR
```

3. Edit the slurm job
- change the accout number to your own
- gputest has only 15 minitues, chnage to gpusmall for longer runs
- source actiavte your own virtual environment

4. submite the job

```
sbatch a100_1device.slurm
```
5. change other slurm scripts accordingly and resubmit the job

6. Here i attach my log files for your reference
