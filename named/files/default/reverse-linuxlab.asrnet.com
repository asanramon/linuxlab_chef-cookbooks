$TTL 3D
@       IN      SOA     dhcpdns.linuxlab.asrnet.com. root.linuxlab.asrnet.com. (
        201401071       ; serial #
        4H              ; refresh
        1H              ; retry
        1W              ; expiry
        1D              ; minimum-ttl
)
@       IN      NS      dhcpdns.linuxlab.asrnet.com.
1       IN      PTR     router.linuxlab.asrnet.com.
2       IN      PTR     dhcpdns.linuxlab.asrnet.com.
3       IN      PTR     chef.linuxlab.asrnet.com.
4       IN      PTR     repo.linuxlab.asrnet.com.
5       IN      PTR     ldap.linuxlab.asrnet.com.
6       IN      PTR     vcs.linuxlab.asrnet.com.
7       IN      PTR     web.linuxlab.asrnet.com.
8       IN      PTR     mysql.linuxlab.asrnet.com.
9       IN      PTR     jenkins.linuxlab.asrnet.com.
10      IN      PTR     puppet.linuxlab.asrnet.com.
11      IN      PTR     cobbler.linuxlab.asrnet.com.
12      IN      PTR     nagios.linuxlab.asrnet.com.
13      IN      PTR     hadoopdn1.linuxlab.asrnet.com.
14      IN      PTR     hadoopdn2.linuxlab.asrnet.com.
15      IN      PTR     hadoopnn1.linuxlab.asrnet.com.
16      IN      PTR     hadoopnn2.linuxlab.asrnet.com.
17		IN		PTR		ntpd.linuxlab.asrnet.com.