docker run -itd --name ansible -p 2222:22 --privileged ubuntu:18.04 bash
docker exec -it ansible bash
apt-get update
apt-get install openssh-server net-tools ansible git vim -y
service ssh start