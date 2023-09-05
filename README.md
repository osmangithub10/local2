# local2

**1. Install virtualbox in your local PC**
-You can use Oracle VM to create Servers. You can just download it.




**2. Create 3 VM with any linux operation system in virtualbox.**
When you open the Oracle VM, you can add new VM with iso file. You can download iso file from ubuntu.com.tr. (Note:When you are creating new VM, you do not need to clone operation because, you can get several problem when you want to create connection between servers.I mean, you can create one by by because of networking problems.In addition, you can chose Bridged Adapter in network settings, when you creating VM.)



**3.Kubernetes cluster Installation with 1 master and 1 node (You can use the Server-1 and Server-2)**
(Note:This is for ubuntu releases and we will download multi node server which are master and node.)
***3.1 Master node installitation on Server 1***

apt-get update -y
//disable swap
swapoff -a

//Install Docker CE
apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
apt-get install docker-ce -y
docker --version  //Sample output -->Docker version 20.10.10, build b485636

//Add Kubernetes Repository
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
apt-get update -y

//Install Kubernetes Components (Kubectl, kubelet and kubeadm)
apt-get install kubelet kubeadm kubectl -y
nano /etc/docker/daemon.json //then add following lines inside deamon.sjon
{ "exec-opts": ["native.cgroupdriver=systemd"],
"log-driver": "json-file",
"log-opts":
{ "max-size": "100m" },
"storage-driver": "overlay2"
}
systemctl daemon-reload
systemctl restart docker
systemctl enable docker

//Initialize Kubernetes Master Node
kubeadm init --pod-network-cidr=10.244.0.0/16 //you can also write only kubeadm init

//Result
Your Kubernetes control-plane has initialized successfully!
Also, you can take some connection token for nodes.You can store it.It looks like "kubeadm join 69.28.84.197:6443 --token tx7by6.nae8saexoj2y3gqb \
--discovery-token-ca-cert-hash sha256:a506a51aa88791b456275b289bedc5d3316534ff67475fdbc7c2c64ace82652f"

//if you connnect as a root you can write this.
export KUBECONFIG=/etc/kubernetes/admin.con

//if you connnect as a regular user you can write this.
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


***3.2 Join Worker Nodes to the Kubernetes Cluster on Server2***
//you can take kubeadm join command from master node result part and copy it.
kubeadm join 69.28.88.236:6443 --token alfisa.guuc5t2f66cpqz8e --discovery-token-ca-cert-hash sha256:1db0bb5317ae1007c1f7774d5281d22b2189b239ffabecaedcd605613a9b10cd

//Result
This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.
Run kubectl get nodes on the control-plane to see this node join the cluster.

//If you dont see token any more, you can just run command on Server 1 which are master node.
kubeadm token create --print-join-command

//Now you can go server 1 which are master and check nodes.
kubectl get nodes
kubectl cluster-info


**4. Jenkins installation in Server-3**
You can follow this addresses to install Jenkins.
https://www.jenkins.io/doc/book/installing/linux/



**5. Docker registry installation in Server-3**
You can follow this addresses to install docker.
https://docs.docker.com/engine/install/ubuntu/


**6. Jenkins pipeline project description**
You need to do some credentials to connect docker and kubernetes.First of all, building image related to Server 3 which means you need to download also docker for server 3.Second,you can connect docker for  pushing images to docker registry. You can go manage jenkins and add some credential for server 2. Thirdly, you need to do some connection for kubernetes on server 1-2. You need to do again some credentials in Jenkins. Also, you need to download some SSH packet to all server.







