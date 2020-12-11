# Preparing a Docker container
docker run -itd --name ansible -p 8080:80 --privileged ubuntu:18.04 bash
docker exec -it ansible bash
apt-get update
apt-get install net-tools ansible git vim -y

# Clone remote repository
git clone https://github.com/serhio17/test-ansible.git
git checkout feature/add-nginx
cd /test-ansible/ansible-project

# Run ansible playbook
ansible-playbook site.yml