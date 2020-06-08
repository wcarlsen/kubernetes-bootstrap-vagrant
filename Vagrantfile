# ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure("2") do |config|

  config.vm.provision "shell", path: "bootstrap.sh"

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
    master.vm.provision "shell", path: "bootstrap_master.sh"
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
    end
  end
end
