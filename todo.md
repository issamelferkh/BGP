# Todo



## Part 0: Prepa Env
- Install 
- [x] VM: Ubuntu 20.04.4 LTS
- [x] Docker
```s
Client: Docker Engine - Community
 Version:           20.10.12
 API version:       1.41
 Go version:        go1.16.12
 Git commit:        e91ed57
 Built:             Mon Dec 13 11:45:33 2021
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.12
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.16.12
  Git commit:       459d0df
  Built:            Mon Dec 13 11:43:42 2021
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.4.13
  GitCommit:        9cc61520f4cd876b86e77edfeb88fbcd536d1f9d
 runc:
  Version:          1.0.3
  GitCommit:        v1.0.3-0-gf46b6ba
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```
- [x] GNS3

## Part 1: GNS3 configuration with Docker.
### Host
  - A first image containing at least busybox or an equivalent: hint Alpine
- Use : docker pull alpine


### Router
- A second image using a system of your choice with the following constraints:
  - A software that manages packet routing (zebra or quagga)..
  - The service BGPD active and configured.
  - The service OSPFD active and configured.
  - An IS-IS routing engine service.
  - Busybox or an equivalent.
- Use : docker pull frrouting/frr

## Part 2: Discovering a VXLAN.
## Part 3: Discovering BGP with EVPN.


bootstrap.min.css
main.css
font-awesome.min.css
owl.carousel.min.css
animate.min.css                 
magnific-popup.css              
owl.theme.default.min.css