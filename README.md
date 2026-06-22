# Jupyter Kernel `srun` Patcher

On a slurm-managed HPC cluster, it is cumbersome to have to manually request a job to start a jupyter server. Instead, we can define the job request in the kernel definition. This implies that each notebook instance is backed by a separate job. This may not be appropriate in all settings and may not be feasible in all HPC environments. I developed this primarily for using VSCode with RemoteSSH on an HPC cluster where I can directly ssh to the compute nodes. Consequently, the patcher then defines the precise node that the kernel job should run on.

**Prerequisites**

* python environment with `ipykernel` installed
* `jq` command-line JSON parser

## Creating a new Kernel

This script can be downloaded and run with this one-liner:
```bash
wget -qO- https://raw.githubusercontent.com/StevenSong/jupyter-kernel-srun-patcher/main/make-kernel.sh | bash -s -- --node <NODE> --name <NAME> [--display-name <DISPNAME>]
```
