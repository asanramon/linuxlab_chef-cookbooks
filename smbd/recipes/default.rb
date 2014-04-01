#
# Cookbook Name:: smbd
# Recipe:: default
#
# Copyright 2014, ASRNet
#
# All rights reserved - Do Not Redistribute
#

%w[ samba samba-common ].each do |svc|
	package svc
end