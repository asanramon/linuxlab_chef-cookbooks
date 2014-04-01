#
# Cookbook Name:: cobbler
# Recipe:: default
#
# Copyright 2014, ASRNet
#
# All rights reserved - Do Not Redistribute
#

package 'cobbler'
package 'cobbler-web'
package 'pykickstart'

cookbook_file "/etc/xinetd.d/tftp" do
	source "tftp"
	notifies :restart,"service[xinetd]"
end

service "xinetd" do
	action [:enable,:start]
end

service "httpd" do
	action [:enable,:start]
end

service "cobblerd" do
	action [:enable,:start]
end