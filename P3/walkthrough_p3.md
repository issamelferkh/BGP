# Part 3: BGP with EVPN

EVPN: Ethernet VPN (rfc7432)

BGP EVPN without MPLS
The controller will learn the MAC addresses
use our VXLAN with ID 10

use priciple of the route reflection (RR)

config leafs (VTEP) (routeurs in  access level) to have a dynamic relations 





## Theory
- Explain simply:
  - What is BGP-EVPN requested in the subject.
  - The principle of road reflection (RR) requested in the subject.
  - What VTEP means as seen in the subject.
  - What VNI means as seen in the subject.
  - The difference between type 2 and type 3 roads seen in the subject.
  - The expected operation of the topology indicated in the subject.

## Practice
- Show you with explanations:
  - The configuration files to set up this part.
  - How to import project 3 into GNS3.
  - How to run these imported machines in GNS3.
  - How to configure all the machines in the subject topology.
  - How to disable all HOST machines in GNS3.
  - No type 2 roads should exist. Only type 3 roads should be shown.
  - The learning process is well done on the VTEPs. 
    - We will have to start up a single host machine and verify that it is well recognized by our VTEPs.
    - No IP address must be configured on this freshly activated host.
    - A type 2 route must be visible when this host is activated.
  - Now enable all host machines and configure IP addresses on each.
  - Everything must work properly. 
    - A simple ping must be used as indicated in the subject.
    - A packet inspection is mandatory.
    - A return close to the example given in the subject is expected here.
  - The VXLAN ID must be set to 10.
  - Packets using the OSPF protocol are visible.





## Questions
int lo
  ip add 1.1.1.2/32 ???


## Config

### Routeur _iel-ferk-1 is the Controller (RR)
hostname _iel-ferk-1
no ipv6 forwarding
!
interface eth0
  ip address 10.1.1.1/30
!
interface eth1
  ip address 10.1.1.5/30
!
interface eth2
  ip address 10.1.1.9/30
!
int lo
  ip add 1.1.1.1/32
!
router bgp 1
  neighbor ibgp peer-group
  neighbor ibgp remote-as 1
  neighbor ibgp update-source lo
  bgp listen range 1.1.1.0/29 peer-group ibgp
  !
  address-family l2vpn evpn
    neighbor ibgp activate
    neighbor ibgp route-reflector-client
  exit-address-family
!
router ospf



9.25




### Routeur _iel-ferk-2
ip link add br0 type bridge
ip link set dev bro up
ip link add vxlan10 type vxlan id 10 dstport 4789
ip link set dev vxlan10 up
brctl addif br0 vxlan10
brctl addif br0 eth1


hostname _iel-ferk-2
no ipv6 forwarding
!
interface eth0
  ip address 10.1.1.2/30
  ip ospt area 0
!
int lo
  ip add 1.1.1.2/32
  ip ospf area 0
!
router bgp 1
  neighbor 1.1.1.1 remote-as 1
  neighbor 1.1.1.1 update-source lo
  !
  address-family l2vpn evpn
    neighbor 1.1.1.1 activate
    advertise-all-vni
  exit-address-family
!
router ospf

### Routeur _iel-ferk-3
### Routeur _iel-ferk-4



