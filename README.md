# Bootstrap Kubernetes cluster with Vagrant
Sometimes spinning up a Kubernetes cluster using Virtualbox is just enough to get going. This accomplish this using Vagrant and Virtualbox. By default it will spin up a master node and one worker node. You will have to manually join the worker node to the cluster.

```bash
# Spin up master and worker node
vagrant up # this will take 5 min

# Get join command for worker node
vagrant ssh master -- -t 'sudo kubeadm token create --ttl 2h --print-join-command'

# Join worker node to cluster
vagrant ssh worker1 -- -t 'sudo kubeadm join [your unique string from above command]'

# Get kube config
vagrant ssh master -- -t 'sudo cat /root/.kube/config'

# When enough is enough (take down cluster)
vagrant destroy
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
```