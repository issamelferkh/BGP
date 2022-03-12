/usr/lib/frr/frrinit.sh start

vtysh << script

configure terminal
hostname routeur_iel-ferk-1
no ipv6 forwarding
!
interface eth0
 ip address 10.1.1.1/30
exit
!
interface eth1
 ip address 10.1.1.5/30
exit
!
interface eth2
 ip address 10.1.1.9/30
exit
!
interface lo
 ip address 1.1.1.1/32
exit
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
exit
!
router ospf
 network 0.0.0.0/0 area 0
!
line vty
!
script

tail -f /dev/null
