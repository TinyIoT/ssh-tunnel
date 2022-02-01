# docker-ssh-tunnel
Dockerized OpenSSH server for port forwarding over SSH. 

The Dockerfile is available [here](https://github.com/farshidtz/docker-ssh-tunnel/blob/master/Dockerfile).

## Run
One or more public keys can be passed as environment variables with
`PUBLIC_KEY_` prefix. E.g.:

```
docker run -d --name tunnel \
    -p 8022:8022 \
    -p 9900-9910:9900-9910 \
    -e PUBLIC_KEY_1="ssh-ed25519 encoded_key user@domain" \
    ghcr.io/farshidtz/ssh-tunnel
```
where 
 * `8022` is the port where the ssh-server can be reached locally
 * `9900-9910` is the range of ports that are forwarded to the host

Alternatively, the authorized_keys files can be passed do the container
in a mounted volume:

```
docker run -d --name tunnel \
    -p 8022:8022 \
    -p 9900-9910:9900-9910 \
    -v $(pwd)/ssh-user:/home/limited/.ssh \
    ghcr.io/farshidtz/ssh-tunnel
```
where 
* `ssh-user` is the directory relative to current path. The public key of the user should be placed in `./ssh-user/authorized_keys` for key-based authentication.


### Get the logs
```
docker logs --timestamps -f tunnel
```

## Open a tunnel (using autossh)
```
autossh -TNn -f -R :$9901:localhost:22 -p 8022 limited@example.com
```
where
 * Local port `22` is forwarded to server as port `9901` at `example.com` public address and `8022` port for the ssh-tunnel server
