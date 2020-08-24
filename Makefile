up:
	vagrant up
	rm join.sh

kube_config:
	mkdir -p ~/.kube
	vagrant ssh master -- -t 'sudo cat /root/.kube/config' > ~/.kube/config

destroy:
	vagrant destroy -f
