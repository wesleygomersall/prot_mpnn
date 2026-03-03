#!/bin/bash

#SBATCH --account=parisahlab
#SBATCH --partition=gpulong
#SBATCH --job-name=design
#SBATCH --output=/home/wesg/prot_mpnn/logs/pmpnn_%x_%j.out
#SBATCH --error=/home/wesg/prot_mpnn/logs/pmpnn_%x_%j.err
#SBATCH --time=9000            ### wall-clock time limit, in minutes
#SBATCH --mem=64G                ### memory limit per node, in GB
#SBATCH --nodes=1               ### number of nodes to use
#SBATCH --ntasks-per-node=1     ### number of tasks to launch per node
#SBATCH --cpus-per-task=4       ### number of cores for each task
#SBATCH --gpus=2
#SBATCH --gres=gpu:2
#SBATCH --mail-type=END
#SBATCH --mail-user=wesg@uoregon.edu

INPUTPDB=/home/wesg/proteinpdbs/Comd_M8/comdn230-c16-12_seed3_model.pdb
OUTPUTDIR=/home/wesg/prot_mpnn/ComD-m8_chainB_outputs/

source ~/miniforge3/etc/profile.d/conda.sh # for conda to work
conda activate mlfold

module load cuda

python /projects/parisahlab/wesg/ProteinMPNN/protein_mpnn_run.py \
    --pdb_path $INPUTPDB \
    --out_folder $OUTPUTDIR \
    --pdb_path_chains B \
    --num_seq_per_target 10000 \
    --sampling_temp 0.2 \
    --batch_size 1
