#
# Cookbook Name:: repo
# Recipe:: default
#
# Copyright 2014, ASRNet
#
# All rights reserved - Do Not Redistribute
#
package "rsync"
package "mod_ssl"
package "httpd"
package "createrepo"

directory "/repo/centos/6.5" do
	owner "root"
	group "root"
	action :create
	not_if {File.directory?("/repo/centos/6.5")}
end

directory "/var/www/html/repo" do
	owner "root"
	group "root"
	action :create
	not_if {File.directory?("/var/www/html/repo")}
end

link "/repo/centos/6" do
	to "/repo/centos/6.5"
	group "root"
	owner "root"
	not_if {File.symlink?("/repo/centos/6")}
end

link "/var/www/html/centos" do
	to "/repo/centos"
	group "root"
	owner "root"
end

cron "sync_with_mirror" do
	command "rsync -avHPS rsync://mirrors.rit.edu/centos/6.5/ /repo/centos/6.5/"
	weekday 0
	hour 23
end

%w[ /repo/centos/custom /repo/centos/custom/RPMS ].each do |path|
	directory path do
		owner "root"
		group "root"
		mode 755
		action :create
		not_if {File.directory?(path)}
	end
end

execute "createrepo" do
	command "createrepo /repo/centos/custom"
end

cookbook_file "/etc/pki/tls/certs/ca.crt" do
	source "ca.crt"
end

cookbook_file "/etc/pki/tls/private/ca.key" do
	source "ca.key"
end

cookbook_file "/etc/pki/tls/private/ca.csr" do
	source "ca.csr"
end

cookbook_file "/etc/httpd/conf.d/repo.conf" do
	source "repo.conf"
	notifies :restart, "service[httpd]"
end

ruby_block "rename_ssl_conf" do
	block do
		if ::File.file?("/etc/httpd/conf.d/ssl.conf")
			::File.rename("/etc/httpd/conf.d/ssl.conf","/etc/httpd/conf.d/ssl.conf.orig")
		end
	end
end

service "httpd" do
	action [:enable,:start]
end

