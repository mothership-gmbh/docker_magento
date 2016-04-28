

# Easy SSH Access

```
    Host mothership
	HostName local.docker
	User root
	IdentityFile /Users/<yourusername>/.ssh/insecure_key
	Port 2222
	CheckHostIP no
	StrictHostKeyChecking no
```

After that just login using

```
ssh mothership
```


# Volumes / mount strategy

# Fast sync
If you want to sync all your data from one directory to another via NFS, you might need A LOT of time.

# Issues

## NFS share can not be mounted or is not available.

First place for every NFS share is your ```/etc/exports``` file. If the mount is not set for your network, then a NFS share is not possible.

```
cat /etc/exports
/Volumes/projects -network 192.168.64.0 -mask 255.255.255.0 -alldirs -maproot=root:wheel
```


## DHCP lease

If you aren't happy with your IP for the local network bridge, check your UUID and update your IP.

```
cat /var/db/dhcpd_leases
```
