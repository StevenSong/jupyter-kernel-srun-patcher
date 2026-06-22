# Jupyter Kernel `srun` Patcher

On a slurm-managed HPC cluster, it is cumbersome to have to manually request a job to start a jupyter server. Instead, we can define the job request in the kernel definition. This implies that each notebook instance is backed by a separate job. This may not be appropriate in all settings and may not be feasible in all HPC environments. I developed this primarily for using VSCode with RemoteSSH on an HPC cluster where I can directly ssh to the compute nodes. Consequently, the patcher then defines the precise node that the kernel job should run on.

**Prerequisites**

* python environment with `ipykernel` installed
* `jq` command-line JSON parser

## Creating a new Kernel

1. SSH to the node you'll be working on (this implies that you'll need to do this for each node you intend to use)
2. Activate the python environment you want to run your kernel (this implies that you'll need to do this for each environment you intend to use)
3. Downloaded and run:
    ```bash
    wget -qO- https://raw.githubusercontent.com/StevenSong/jupyter-kernel-srun-patcher/main/make-kernel.sh | bash -s -- --name <NAME> [--display-name <DISPNAME>]
    ```

**VSCode Tips**
* in a notebook in VSCode, open the kernel selector > "Select Another Kernel" > "Jupyter Kernel"
  * see [VSCode docs](https://code.visualstudio.com/docs/datascience/jupyter-kernel-management)
* in VSCode, you may need to reload the session for it to pick up the kernel (use "Developer: Reload Window" from the command palette)
* be judicious about managing your jobs, sometimes VSCode does not kill off kernels correctly
