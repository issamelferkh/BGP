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
  ip address 10.1.1.6/30
  ip ospt area 0
!
int lo
  ip add 1.1.1.6/32
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

tail -f /dev/null