#!/bin/bash

cd /home/vagrant/slurm-24.05.6/etc

sudo sed -i 's/^#StorageHost=localhost/StorageHost=localhost/' slurmdbd.conf.example
sudo sed -i 's/^#StorageLoc=slurm_acct_db/StorageLoc=slurm_acct_db'/ slurmdbd.conf.example
sudo sed -i 's/^SlurmUser=slurm/SlurmUser=root/' slurmdbd.conf.example

sudo sed -i 's/^AccountingStorageType=accounting_storage\/none/AccountingStorageType=accounting_storage\/slurmdbd/' /usr/local/etc/slurm.conf

sudo sed -i 's/^User=slurm/User=root/' slurmdbd.service
sudo sed -i 's/^Group=slurm/Group=root/' slurmdbd.service

sudo cp slurmdbd.conf.example /usr/local/etc/slurmdbd.conf
sudo cp slurmdbd.service /etc/systemd/system/

sudo chmod 600 /usr/local/etc/slurmdbd.conf

DB_USER="slurm"
DB_PASS="password"
DB_NAME="slurm_acct_db"

# Execute MySQL commands
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';
FLUSH PRIVILEGES;
EOF

sudo systemctl daemon-reload


touch slurmdbd-installed-successfully