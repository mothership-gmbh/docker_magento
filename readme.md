

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





## Debugging

The PHP-FPM xdebug extension will broadcast all outgoing connections to the remote port ```9999```. The default port is 9000 but this is reserved by the php-fpm
container. To enable debugging, you need to edit the PHPStorm preferences. "Languages & Frameworks > PHP > Debug". You can set it for the current project but also for any other one.

## Hints

There are some tweaks and commands which will make your life easier. For example:

### Commands

Check the directory ```docker_magento/dockerfiles/php-fpm/home/.bashrc``` which contains some alias for example to quickly navigate from one directory to another.

# The docker file contains different containers

## PHP-FPM

# MariaDB

## Rebuild the database

The database container will check for every data in the mounted directory ```${PROJECT_VOlUME}/db``` . If that directory is empty then for every file which is in
the directory ```docker-entrypoint-initdb.d``` the sql file will be imported. Please check the official [documentation](https://hub.docker.com/_/mariadb/) for further details.

```
    # add the local db to the entrypoint
      - ./db:/docker-entrypoint-initdb.d
```

Otherwise you can manually import the database with ```magerun db:import``` or by logging into the database container and running some queries.





## Elasticsearch

## Certificates

http://www.selfsignedcertificate.com/