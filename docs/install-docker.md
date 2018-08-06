# Steps to install docker on jumpbox or client machine
Reference: https://docs.docker.com/install/linux/docker-ce/ubuntu/

```
sudo apt-get remove docker docker-engine docker.io

sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get -y install docker-ce
sudo docker info
sudo docker run hello-world
```

Steps to add a specific user to docker group:
```
sudo usermod -a -G docker $USER
```
