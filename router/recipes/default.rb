#
# Cookbook Name:: router
# Recipe:: default
#
# Copyright 2014, ASRNet
#
# All rights reserved - Do Not Redistribute
#
cookbook_file "/etc/sysconfig/network-scripts/ifcfg-eth0" do
	source "ifcfg-eth0"
	owner "root"
	group "root"
	notifies :restart, "service[network]"
end

cookbook_file "/etc/sysconfig/network-scripts/ifcfg-eth1" do
	source "ifcfg-eth1"
	owner "root"
	group "root"
	notifies :restart,"service[network]"
end

service "network" do
	action :nothing
end

execute "forward_packet" do
	command "sysctl -w net.ipv4.ip_forward=1"
end

template "/etc/sysconfig/iptables" do
	source "iptables.erb"
end