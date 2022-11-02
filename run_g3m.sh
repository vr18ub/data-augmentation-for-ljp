#!/bin/bash
#SBATCH --job-name="GPT3Mix test"
###SBATCH --mail-user=
#SBATCH --mail-type=end,fail
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=00-04:00:00
#SBATCH --mem=128GB
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx3090:1
#SBATCH --qos=job_gpu
#SBATCH --partition=gpu

# enable this when on gpu partition (and NOT on gpu-invest)
###SBATCH --qos=job_gpu_preempt
# enable this to get a time limit of 20 days
###SBATCH --qos=job_gpu_stuermer

# alternatively run multiprocess on 6 gtx1080ti gpus with qos job_gpu_preempt (further reduce batch size): only works with opus-mt model

# Activate correct conda environment
module load Anaconda3
eval "$(conda shell.bash hook)"
conda activate data_aug

# Put your code below this line
python data_augmentation/hypermix/main.py --datasets court --augmenter gpt3-mix --save-dir data/gpt3mix/out

