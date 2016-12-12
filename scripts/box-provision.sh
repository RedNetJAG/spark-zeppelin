echo "# Start provisioning"

echo "# update system"
sudo yum makecache fast

echo "# install unzip + vim"
sudo yum -y install unzip vim

echo "#######################################################################"
echo "# install python3"
echo "#######################################################################"
sudo yum -y install epel-release
sudo yum -y install python34 python34-setuptools
sudo easy_install-3.4 pip
echo "export PYSPARK_PYTHON=python3" >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc

echo "#######################################################################"
echo "# install matplotlib numpy scipy scikit-learn pandas"
echo "#######################################################################"
sudo yum -y install python-matplotlib
sudo pip install -U numpy
sudo pip install -U scipy
sudo pip install -U scikit-learn
sudo pip install -U pandas
sudo pip install -U igraph


echo "#######################################################################"
echo "# install scala 2.11"
echo "#######################################################################"
cd ~
wget http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.rpm
sudo yum -y install scala-2.11.8.rpm
rm ~/scala-2.11.8.rpm

echo "#######################################################################"
echo "# Starting procceses...."
echo "#######################################################################"
start-master.sh
start-slave.sh spark://spark.bd:7077 -m 2G
zeppelin-daemon.sh start

echo "#######################################################################"
echo "# End provisioning"
echo "#######################################################################"
