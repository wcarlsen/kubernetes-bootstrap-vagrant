# ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure("2") do |config|

  # config.vm.provision "shell", path: "bootstrap.sh"

  # Master node
  config.vm.define "master" do |master|
    master.vm.box = "ubuntu/bionic64"
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "172.42.42.100"
    master.vm.provider "virtualbox" do |vb|
      vb.name = "master"
      vb.memory = "1024"
      vb.cpus = "2" # min 2 required
    end
    master.vm.provision "shell", privileged: false, path: "bootstrap.sh"
    master.vm.provision "shell", privileged: false, path: "bootstrap_master.sh"
    master.vm.provision "shell", privileged: false, inline: <<-SHELL
sudo apt-get -y install etcd-client
SHELL
    master.vm.provision "shell", privileged: false, inline: <<-SHELL
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
echo "alias k=kubectl" >> ~/.bashrc
echo "export do='--dry-run=client -o yaml'" >> ~/.bashrc
echo "complete -F __start_kubectl k" >> ~/.bashrc
echo "set tabstop=2 shiftwidth=2 expandtab autoindent number" >> ~/.vimrc
SHELL
  end

  # Worker nodes
  WORKERS = 1

  (1..WORKERS).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.box = "ubuntu/bionic64"
      worker.vm.hostname = "worker#{i}"
      worker.vm.network "private_network", ip: "172.42.42.10#{i}"
      worker.vm.provider "virtualbox" do |vb|
        vb.name = "worker#{i}"
        vb.memory = "1024"
        vb.cpus = "1"
      end
      worker.vm.provision "shell", privileged: false, path: "bootstrap.sh"
      worker.vm.provision "shell", privileged: false, inline: <<-SHELL
sudo /vagrant/join.sh
echo 'Environment="KUBELET_EXTRA_ARGS=--node-ip=172.42.42.10#{i}"' | sudo tee -a /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
sudo systemctl daemon-reload
sudo systemctl restart kubelet
SHELL
    end
  end
end
