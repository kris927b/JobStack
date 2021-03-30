#!/bin/bash

#SBATCH --job-name=machamp_mtl_bert          # Job name
#SBATCH --output=job.%j.out      # Name of output file (%j expands to jobId)
#SBATCH --cpus-per-task=8        # Schedule 8 cores (includes hyperthreading)
#SBATCH --gres=gpu               # Schedule a GPU
#SBATCH --time=24:00:00          # Run time (hh:mm:ss) - run for one hour max
#SBATCH --partition=brown,red    # Run on either the Red or Brown queue
#SBATCH --mail-type=FAIL,END     # Send an email when the job finishes or fails

cd /home/krnj/mtp

echo "Running on $(hostname):"
module --ignore-cache load TensorFlow/2.2.0-fosscuda-2019b-Python-3.7.4
module load Anaconda3
. $(conda info --base)/etc/profile.d/conda.sh
# module list

conda activate machamp

for c in 1 2 3
do
# CoNLL
python train.py --dataset_config configs/Stack/MTL.conll.json --parameters_config configs/Stack/bert.$c.json --device 0 --name MTL.conll.bert.$c

# I2B2
python train.py --dataset_config configs/Stack/MTL.i2b2.json --parameters_config configs/Stack/bert.$c.json --device 0 --name MTL.i2b2.bert.$c

# Both
python train.py --dataset_config configs/Stack/MTL.both.json --parameters_config configs/Stack/bert.$c.json --device 0 --name MTL.both.bert.$c
done
conda deactivate