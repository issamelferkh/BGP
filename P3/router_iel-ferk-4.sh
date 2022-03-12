ip link add br0 type bridge
ip link set dev br0 up
ip link add vxlan10 type vxlan id 10 dstport 4789
ip link set dev vxlan10 up
brctl addif br0 vxlan10
brctl addif br0 eth1
touch /etc/frr/vtysh.conf


vtysh <<end
configure terminal

no ipv6 forwarding
hostname R_iel-ferk-2
!
interface eth2
 ip address 10.1.1.10/30
 ip ospf area 0
exit
!
interface lo
 ip address 1.1.1.4/32
 ip ospf area 0
exit
!
router bgp 1
 neighbor 1.1.1.1 remote-as 1
 neighbor 1.1.1.1 update-source lo
 !
 address-family l2vpn evpn
  neighbor 1.1.1.1 activate
  advertise-all-vni
 exit-address-family
exit
!
router ospf
exit
!
end




tail -f /dev/null
