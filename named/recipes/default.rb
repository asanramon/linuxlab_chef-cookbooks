#
# Cookbook Name:: named
# Recipe:: default
#
# Copyright 2014, ASRNet
#
# All rights reserved - Do Not Redistribute
#

package "bind"

cookbook_file "/etc/named.conf" do
	source "named.conf"
	owner "root"
	group "named"
	mode 0640
	notifies :restart,"service[named]"
end

cookbook_file "/var/named/master-linuxlab.asrnet.com" do
	source "master-linuxlab.asrnet.com"
	owner "named"
	group "named"
	mode 0640
	notifies :restart,"service[named]"
end

cookbook_file "/var/named/reverse-linuxlab.asrnet.com" do
	source "reverse-linuxlab.asrnet.com"
	owner "named"
	group "named"
	mode 0640
	notifies :restart,"service[named]"
end

service "named" do
	action [:enable,:start]
end

bash "open_firewall" do
	code <<-EOH
		chain=$(cat /etc/sysconfig/iptables | grep "^-A INPUT -p udp -m state --state NEW -m udp --dport 53 -j ACCEPT")
		if [ -z "$chain" ]; then
		        iptables -I INPUT -m state --state NEW -m udp -p udp --dport 53 -j ACCEPT
		        service iptables save
		fi
		chain=$(cat /etc/sysconfig/iptables | grep "^-A INPUT -p tcp -m state --state NEW -m tcp --dport 53 -j ACCEPT")
		if [ -z "$chain" ]; then
		        iptables -I INPUT  -m state --state NEW -m tcp -p tcp --dport 53 -j ACCEPT
		        service iptables save
		fi
	EOH
end
