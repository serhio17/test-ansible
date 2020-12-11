# Preparing a Docker container
docker run -itd --name ansible -p 8080:80 --privileged ubuntu:18.04 bash
docker exec -it ansible bash
apt-get update
apt-get install net-tools ansible git vim -y

# Clone remote repository
git clone https://github.com/serhio17/test-ansible.git
cd /test-ansible/
git checkout feature/add-nginx
cd ansible-project

# Run ansible playbook
ansible-playbook site.yml

# Check that NGINX works as execpected
http://localhost:8080/