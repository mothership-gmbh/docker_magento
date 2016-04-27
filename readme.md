

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


# Volumes