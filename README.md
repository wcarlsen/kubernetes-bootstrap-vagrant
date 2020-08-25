# Bootstrap Kubernetes cluster with Vagrant
Sometimes spinning up a Kubernetes cluster using Virtualbox is just enough to get going. This project accomplish this using [Vagrant](https://www.vagrantup.com/) and [Virtualbox](https://www.virtualbox.org/). By default it will spin up a master node and one worker node. You will have to manually join the worker node to the cluster.

This setup follows the Linux Academy CKA instructions for bootstraping a cluster and hence this setup should be ideal for preparing for the CKA and CKAD exams.

Requirements:
* vagrant
* virtualbox
* kubectl
* plenty of CPU and memory ressources...

```bash
# Spin up master and worker node(s)
make up # this will take 5 min

# Get kube config
make kube_config

# Verify that worker node joined the cluster (using the above kube config from host machine)
kubectl get nodes -w

# When enough is enough (take down cluster)
make destroy
```

Remember that you can increase the node count by changing the `WORKER = 1` parameter in the Vagrantfile.

If you want to obtain ssh access to the cluster master and worker nodes use the following commands:

```bash
# Master and worker nodes ssh access
vagrant ssh master
# or
vagrant ssh worker1

# Become root user
sudo su
# or
sudo -i
```
