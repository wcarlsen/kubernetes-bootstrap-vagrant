#!/bin/bash

OUTPUT_FILE=/vagrant/join.sh
rm -rf $OUTPUT_FILE

# Initialize cluster
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=172.42.42.100 | grep -A 2 "kubeadm join" > ${OUTPUT_FILE}
chmod +x $OUTPUT_FILE

# Setup local kubeconfig
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Fix kubelet IP
echo 'Environment="KUBELET_EXTRA_ARGS=--node-ip=172.42.42.100"' | sudo tee -a /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
sudo systemctl daemon-reload
sudo systemctl restart kubelet

# Add CNI
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml