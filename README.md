# Info about the enviroment
### This project is created with **Vagrant**
```
vagrant version 
Installed Version: 2.3.4
```
### The box for env is generic/rock9 and uses libvirt as a provider
```
vagrant box list 
generic/rocky9 (libvirt, 4.3.12)
```
# Architecture
## ClusterA
  - Slurmctld
  - Slurmdbd
  - Mysql
  - 1 Compute node *computA*
## ClusterB
  - Slurmctld
  - 1 compute node *computaB*
### All the components of both clusters share the same munge key
# Softwares and versions
### Slurm
```
scontrol --version
slurm 24.05.6
```
### Munge
```
munge -V
munge-0.5.16 (2024-03-15)
```

## Multi-Cluster design
##### The multi-cluster mode is implemented by sharing the same slurmdbd and mysql, which is hosted on ControllerA, with both clusters <br/> this from *slurm.conf*
> # LOGGING AND ACCOUNTING
> AccountingStorageHost=controllerA <br/>
> AccountingStorageType=accounting_storage/slurmdbd

##### Viewing available clusters

```
[vagrant@controllerA ~]$ sacctmgr show cluster withfed
   Cluster     ControlHost  ControlPort   RPC     Share GrpJobs       GrpTRES GrpSubmit MaxJobs       MaxTRES MaxSubmit     MaxWall                  QOS   Def QOS Federation     ID             Features     FedState 
---------- --------------- ------------ ----- --------- ------- ------------- --------- ------- ------------- --------- ----------- -------------------- --------- ---------- ------ -------------------- ------------ 
  clustera  192.168.124.91         6817 10496         1                                                                                           normal           multiclus+      1                            ACTIVE 
  clusterb 192.168.124.187         6817 10496         1                                                                                           normal           multiclus+      2                            ACTIVE
```
##### And is leveraged by creating a cluster federation called *multicluster*
```
[vagrant@controllerA ~]$ scontrol show federation
Federation: multicluster
Self:       clustera:192.168.124.91:6817 ID:1 FedState:ACTIVE Features:
Sibling:    clusterb:192.168.124.187:6817 ID:2 FedState:ACTIVE Features: PersistConnSend/Recv:Yes/Yes Synced:Yes
```

