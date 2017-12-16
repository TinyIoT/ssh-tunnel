# docker-ssh-tunnel
Dockerized OpenSSH server for port forwarding over SSH. 

The Dockerfile is available [here](https://github.com/farshidtz/docker-ssh-tunnel/blob/master/Dockerfile).

## Build
### Extract SSH config file from a temporary container
```
docker run -d --rm --name temptunnel farshidtz/ssh-tunnel
docker cp temptunneler:/etc/ssh ./ssh-conf
docker stop temptunnel
```

Add the following to the end of `./ssh-conf/sshd_config`:
```
GatewayPorts yes
AllowAgentForwarding no
ForceCommand echo 'Not Allowed.'
ClientAliveInterval 100
ClientAliveCountMax 3
```

## Run
```
docker run -d --name tunnel \
    -p 8822:22 \
    -p 9900-9910:9900-9910 \
    -v $(pwd)/limited-home:/home/limited/.ssh \
    -v $(pwd)/ssh-conf:/etc/ssh \
    farshidtz/ssh-tunnel
```
where 
 * `8822` is the port where the ssh-server can be reached locally
 * `9900-9910` is the range of ports that are forwarded to the host
 * `limited-home` is the home directory of the `limited` user. The public key of the user should be placed in `./limited-home/.ssh/authorized_keys` for key-based authentication.
 * `ssh-conf` is the directory containing ssh server config files
 
### Get the logs
```
docker logs --timestamps -f tunnel
```

## Open a tunnel (using autossh)
```
autossh -TNn -f -R :$9901:localhost:22 -p 8822 limited@example.com
```
where
 * Local port `22` is forwarded to server as port `9901` at `example.com` public address and `8822` port for the ssh-tunnel server
