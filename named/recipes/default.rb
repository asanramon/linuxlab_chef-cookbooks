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

template "/var/named/master-linuxlab.asrnet.com" do
	source "master-linuxlab.asrnet.com.erb"
	owner "named"
	group "named"
	mode 0640
	notifies :restart,"service[named]"
end

template "/var/named/reverse-linuxlab.asrnet.com" do
	source "reverse-linuxlab.asrnet.com.erb"
	owner "named"
	group "named"
	mode 0640
	notifies :restart,"service[named]"
end

service "named" do
	action [:enable,:start]
end
