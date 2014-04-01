#
# Cookbook Name:: pxe
# Recipe:: default
#
# Copyright 2014, ASRNet
#
# All rights reserved - Do Not Redistribute
#
#package "tftp-server"
package "syslinux"
package "dnsmasq"

#cookbook_file "/etc/xinetd.d/tftp" do
#	source "tftp"
#	notifies :restart,"service[xinetd]"
#end

#service "xinetd" do
#	action [:enable,:start]
#end

cookbook_file "/etc/dnsmasq.conf" do
	source "dnsmasq.conf"
	notifies :restart,"service[dnsmasq]"
end

service "dnsmasq" do
	action [:enable,:start]
end

remote_file "/var/lib/tftpboot/pxelinux.0" do
	source "file:///usr/share/syslinux/pxelinux.0"
end

remote_file "/var/lib/tftpboot/menu.c32" do
	source "file:///usr/share/syslinux/menu.c32"
end

remote_file "/var/lib/tftpboot/memdisk" do
	source "file:///usr/share/syslinux/memdisk"
end

remote_file "/var/lib/tftpboot/mboot.c32" do
	source "file:///usr/share/syslinux/mboot.c32"
end

remote_file "/var/lib/tftpboot/chain.c32" do
	source "file:///usr/share/syslinux/chain.c32"
end

directory "/var/lib/tftpboot/pxelinux.cfg" do
end

remote_directory "/var/lib/tftpboot/pxelinux.cfg" do
	source "pxe"
end

directory "/var/lib/tftpboot/images/centos/6.5/x86_64" do
	action :create
	recursive true
end

remote_file "/var/lib/tftpboot/images/centos/6.5/x86_64/initrd.img" do
	source "https://repo.linuxlab.asrnet.com/centos/6.5/os/x86_64/images/pxeboot/initrd.img"
	mode 0744
end

remote_file "/var/lib/tftpboot/images/centos/6.5/x86_64/vmlinuz" do
	source "https://repo.linuxlab.asrnet.com/centos/6.5/os/x86_64/images/pxeboot/vmlinuz"
	mode 0744
end

remote_file "/var/lib/tftpboot/images/windows/winpe_x86.iso" do
	source "https://repo.linuxlab.asrnet.com/windows/winpe/winpe_x86.iso"
	mode 0744
end

remote_file "/var/lib/tftpboot/images/windows/winpe_x64.iso" do
	source "https://repo.linuxlab.asrnet.com/windows/winpe/winpe_x64.iso"
	mode 0744
end
