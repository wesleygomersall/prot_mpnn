#!/bin/bash

#SBATCH --account=parisahlab
#SBATCH --partition=gpu
#SBATCH --job-name=newlig
#SBATCH --output=/home/wesg/prot_mpnn/logs/pmpnn_%x_%j.out
#SBATCH --error=/home/wesg/prot_mpnn/logs/pmpnn_%x_%j.err
#SBATCH --time=900            ### wall-clock time limit, in minutes
#SBATCH --mem=64G                ### memory limit per node, in GB
#SBATCH --nodes=1               ### number of nodes to use
#SBATCH --ntasks-per-node=1     ### number of tasks to launch per node
#SBATCH --cpus-per-task=4       ### number of cores for each task
#SBATCH --gpus=2
#SBATCH --gres=gpu:2
#SBATCH --mail-type=END
#SBATCH --mail-user=wesg@uoregon.edu

INPUTPDB=/home/wesg/proteinpdbs/C16_fromAF3multimer.pdb
OUTPUTDIR=/home/wesg/prot_mpnn/c16outputs/

source ~/miniforge3/etc/profile.d/conda.sh # for conda to work
conda activate mlfold

module load cuda

python /projects/parisahlab/wesg/ProteinMPNN/protein_mpnn_run.py \
    --pdb_path $INPUTPDB \
    --out_folder $OUTPUTDIR \
    --num_seq_per_target 10 \
    --sampling_temp 0.2 \
    --batch_size 1
