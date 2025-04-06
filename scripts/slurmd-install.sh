#!/bin/bash

tar -xaf slurm-24.05.6.tar.bz2
cd ./slurm-24.05.6

sudo ./configure
sudo make -j 2
sudo make install

cd /home/vagrant/slurm-24.05.6/etc

if [[ "$(hostname)" == "computeA" ]];then
    sudo sed -i 's/^ClusterName=cluster/ClusterName=clusterA/' slurm.conf.example
    sudo sed -i 's/^SlurmctldHost=linux0/SlurmctldHost=controllerA/' slurm.conf.example
    sudo sed -i 's|^NodeName=linux\[1-32\] CPUs=1 State=UNKNOWN|NodeName=computeA CPUs=2 State=UNKNOWN|' slurm.conf.example
else
    sudo sed -i 's/^ClusterName=cluster/ClusterName=clusterB/' slurm.conf.example
    sudo sed -i 's/^SlurmctldHost=linux0/SlurmctldHost=controllerB/' slurm.conf.example
    sudo sed -i 's|^NodeName=linux\[1-32\] CPUs=1 State=UNKNOWN|NodeName=computeB CPUs=2 State=UNKNOWN|' slurm.conf.example
fi


sudo sed -i 's/^#AccountingStorageHost=/AccountingStorageHost=controllerA/' slurm.conf.example
sudo sed -i 's/^SlurmUser=slurm/SlurmUser=root/' slurm.conf.example
sudo sed -i 's/^AccountingStorageType=accounting_storage\/none/AccountingStorageType=accounting_storage\/slurmdbd/' slurm.conf.example



sudo chown -R root:root /home/vagrant/slurm-24.05.6/etc
sudo cp ./slurm.conf.example /usr/local/etc/slurm.conf


sudo mv ./slurmd.service /etc/systemd/system/slurmd.service

sudo systemctl daemon-reload


touch slurm-installed-successfully