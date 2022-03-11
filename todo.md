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
setting up your first VXLAN (RFC 7348) network
First in static then in dynamic multicast.

- Config
  - VLAN ID: 10
  - Name: vxlan10
  - setup bridge: br0
  - Ethernet interfaces, as we like: (@IPs ) 

host 1    30.1.1.1
host 2    30.1.1.2

- Test inspect traffic between two host in same our vlan

### Files
P2.gns3project

touch _kzouggar-1_g
touch _kzouggar-1_host
touch _kzouggar-1_host_cmd
touch _kzouggar-1_s
touch _kzouggar-2_g
touch _kzouggar-2_host
touch _kzouggar-2_host_cmd
touch _kzouggar-2_s



### Config Static
#### Routeur 1
eth0 is the int connected to the switch
eth1 is the int connected to the host

- setup and up bridge int br0
> ip link add br0 type bridge
> ip link set device br0 up

- Config @IP for eth0 int
> ip addr add 10.1.1.1/24 device eth0
> ip addr show eth0

- Create VXLAN interface  
> ip link add name vxlan10 type vxlan id 10 device eth0 remote 10.1.1.2 local 10.1.1.1 dstport 4789

- Config @IP for vxlan10 int
> ip addr add 20.1.1.1/24 dev vxlan10
> ip link set dev vxlan10 up
> ip -d link show vxlan10

- Associate vxlan and eth network eth1 to be part of one bridge !!! so make eth1 part of br0
bridge control add interface  
> brctl addif br0 eth1
> brctl addif br0 vxlan10



##### #########
ip link add br0 type bridge
ip link set device br0 up
ip addr add 10.1.1.1/24 device eth0
ip link add name vxlan10 type vxlan id 10 device eth0 remote 10.1.1.2 local 10.1.1.1 dstport 4789
ip addr add 20.1.1.1/24 dev vxlan10
ip link set dev vxlan10 up
brctl addif br0 vxlan10




#### Routeur 2
eth0 is the int connected to the switch
eth1 is the int connected to the host

- setup and up bridge int br0
> ip link add br0 type bridge
> ip link set device br0 up

- Config @IP for eth0 int
> ip addr add 10.1.1.2/24 device eth0
> ip addr show eth0

- Create VXLAN interface  
> ip link add name vxlan10 type vxlan id 10 device eth0 remote 10.1.1.1 local 10.1.1.2 dstport 4789

- Config @IP for vxlan10 int
> ip addr add 20.1.1.2/24 dev vxlan10
> ip link set dev vxlan10 up
> ip -d link show vxlan10

- Associate vxlan and eth network eth1 to be part of one bridge !!! so make eth1 part of br0
bridge control add interface  
> brctl addif br0 eth1
> brctl addif br0 vxlan10


##### #########
ip link add br0 type bridge
ip link set device br0 up
ip addr add 10.1.1.2/24 device eth0
ip link add name vxlan10 type vxlan id 10 device eth0 remote 10.1.1.1 local 10.1.1.2 dstport 4789
ip addr add 20.1.1.2/24 dev vxlan10
ip link set dev vxlan10 up
brctl addif br0 vxlan10


#### host 1
- add @IP
> ip addr add 30.1.1.1/24 dev eth1

#### host 2
- add @IP
> ip addr add 30.1.1.2/24 dev eth1



#### Switch












## Part 3: Discovering BGP with EVPN.

