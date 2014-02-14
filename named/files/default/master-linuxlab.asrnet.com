$TTL 3D
@       IN      SOA     dhcpdns.linuxlab.asrnet.com. root.linuxlab.asrnet.com. (
        201401071       ; serial #
        4H              ; refresh
        1H              ; retry
        1W              ; expiry
        1D              ; minimum-ttl
)
@               IN      NS      dhcpdns.linuxlab.asrnet.com.
router          IN      A       10.10.2.1
dhcpdns         IN      A       10.10.2.2
chef            IN      A       10.10.2.3
repo            IN      A       10.10.2.4
ldap            IN      A       10.10.2.5
vcs             IN      A       10.10.2.6
web             IN      A       10.10.2.7
mysql           IN      A       10.10.2.8
jenkins         IN      A       10.10.2.9
puppet          IN      A       10.10.2.10
cobbler         IN      A       10.10.2.11
nagios          IN      A       10.10.2.12
hadoopdn1       IN      A       10.10.2.13
hadoopdn2       IN      A       10.10.2.14
hadoopnn1       IN      A       10.10.2.15
hadoopnn2       IN      A       10.10.2.16
ntpd            IN      A       10.10.2.17
linuxclient1    IN      A       10.10.2.18