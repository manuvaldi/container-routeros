Docker container to run Mikrotik RouterOS base on @vaerh work

### Usage

```
podman run -d --rm \
  --cap-add=NET_ADMIN \
  -v /dev/net/tun:/dev/net/tun \
  -p 2222:22   \
  -p 8728:8728 \
  -p 8729:8729 \
  -p 5900:5900 \
  -e VM_NAME=mik-router
  -e VM_MEMORY=256M
  -e VM_DISK_SIZE=256M
  --name routeros \
quay.io/mvalledi/routeros:latest
```

### Parameters

* `VM_NAME`: Set VM Name to qemu. By default `routeros`.

* `VM_MEMORY`: Set memory to the router VM. By default 128M.

* `VM_DISK_SIZE`: Resize disk to the value before run. By default 128M.

### Persistence

If you wish to persist the changes even after stopping/killing or making changes to the Docker/pod, you can attach a volume to the path `/routeros-instance`. The container will copy the default RouterOS image to `/routeros-instance/routeros.img` if it doesn't exists.

For example:

```
podman run --rm --name routeros
   -e VM_DISK_SIZE=256M \
   -p 2222:22 -p 8728:8728 -p 8729:8729 -p 5900:5900 -p8291:8291 \
   -v /home/routeros:/routeros-instance \
   --privileged --group-add keep-groups -ti \
   quay.io/mvalledi/routeros:latest

```

### Notes
You can connect to your RouterOS container via VNC protocol (on localhost 5900 port)

## List of exposed ports

| Description | Ports |
|-------------|-------|
| Defaults    | 21, 22, 23, 80, 443, 8291, 8728, 8729 |
| IPSec       | 50, 51, 500/udp, 4500/udp |
| OpenVPN     | 1194/tcp, 1194/udp |
| L2TP        | 1701 |
| PPTP        | 1723 |
| Radius      | 1812/udp, 1813/udp |
| VNC         | 5900 |
| Winbox      | 8291 |
| API         | 8728, 8729 |


## Links
* https://github.com/vaerh/docker-routeros
* https://github.com/EvilFreelancer/docker-routeros
* https://github.com/joshkunz/qemu-docker
* https://github.com/ennweb/docker-kvm
* https://gist.github.com/dghubble/c2dc319249b156db06aff1d49c15272e
