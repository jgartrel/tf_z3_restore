# tf_z3_restore

## Getting Started
Launching a restore node in EC2 is pretty easy once `terraform` is installed (see [Setup - MacOSX](Setup_MacOSX.md)).  Simply follow these steps:
```
# This only needs to be done once
terraform init

# Plan and launch the restore instance
terraform plan
terraform apply
```

## Final Configuration
```
# SSH to the instance using the IP address from above, and become root
ssh -l ubuntu -i `terraform output ssh_private_key` `terraform output ssh_public_ip`
sudo su -

# Import the gpg private key and trust for z3_backup
vi priv.key
gpg --import priv.key
echo  "1701EE16A916FCBFA0C0975F3191C40840048964:6:" | gpg --import-ownertrust

# Add AWS Credentials to configuration file for z3_backup
vi /etc/z3_backup/z3.conf
```

## Restoring Backups
```
# Use Z3 to restore a backup snapshot
z3 status
z3 restore zfs-auto-snap:daily:20190324070932 --dry-run
z3 restore zfs-auto-snap:daily:20190324070932
```

## Cleaning up
```
# The zpool will need to be removed before tearing down the instance
zpool destroy time_capsule

# Run the following command locally to tear down the instance when finished
terraform destroy
```

### TODO
* Use IAM role for s3 authentication / permissions
* Create a better system for transporting GPG private key and trust
