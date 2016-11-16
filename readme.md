

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
If you want to sync all your data from one directory to another via NFS, you might need A LOT of time as data transfer via nfs is not as fast as a direct copy from the disk. I recommend using the script ```sync.sh``` which completely deletes the target volume and use ```rsync``` to keep the volume in sync.

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

## Network Configuration

The Mac has a changing IP address (or none if you have no network access). Our current recommendation is to attach an unused IP to the lo0 interface on the Mac; for example: sudo ifconfig lo0 alias 10.200.10.1/24, and make sure that your service is listening on this address or 0.0.0.0 (ie not 127.0.0.1). Then containers can connect to this address.

## Output all logs

```
watch -n 5  "tail -f /var/www/share/dev/htdocs/www/var/log/* > /var/log/syslog"
```
