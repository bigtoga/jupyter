# AD Ports and Protocols
```asa
object-group service AD-PORTS
   service-object tcp-udp destination eq domain 
   service-object tcp-udp destination eq 88 
   service-object udp destination eq ntp 
   service-object tcp destination eq 135 
   service-object tcp-udp destination eq 137 
   service-object udp destination eq netbios-dgm 
   service-object tcp destination eq netbios-ssn 
   service-object tcp-udp destination eq 389 
   service-object tcp-udp destination eq 445 
   service-object tcp-udp destination eq 464 
   service-object tcp destination eq ldaps 
   service-object tcp destination eq 3268 
   service-object tcp destination eq 3269 
   service-object tcp destination eq 5722 
   service-object tcp destination eq 9389 
   service-object tcp-udp destination range 49152 65535 
   
...

access-list FW-INSIDE extended permit object-group AD-PORTS any object-group AD-SERVERS 
 ```
 
**TCP Ports** - 88, 135, 137, 3268, 3269, 5722, 9389, range of 49152:65535

**UDP Ports** - 88, 137, 389, 445, 464, range of 49152:65535


# Port Query v2 is your friend

[GUI version](https://www.microsoft.com/en-us/download/details.aspx?id=24009) - [command line version](https://www.microsoft.com/en-us/download/details.aspx?id=17148)

UI version has Active Directory ports

# Command line

DCDIAG /TEST:DNS /V /E /F:"C:\DNS Logs\20210216_0140.txt"

NLTEST /DSGETDC:mydomain.com >> "C:\DNS Logs\nltest_mydomain.txt"
NLTEST /DSGETDC:stg.mydomain.com >> "C:\DNS Logs\nltest_stg.txt"

NLTEST /DSGETDC:mydomain.com /GC >> "C:\DNS Logs\nltest_forest.txt"