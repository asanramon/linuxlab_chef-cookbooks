#
# Cookbook Name:: ntpd
# Recipe:: default
#
# Copyright 2014, ASRNet
# All rights reserved - Do Not Redistribute
#
package "ntp"

cookbook_file "/etc/ntp.conf" do
	source "ntp.conf"
	notifies :restart,"service[ntpd]"
end

cookbook_file "/etc/sysconfig/iptables" do
	source "iptables"
	notifies :restart,"service[iptables]"
end

service "ntpd" do
	action [:enable,:start]
end

service "iptables" do
	action :nothing
end