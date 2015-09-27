require "webmock"
Object.send(:include, WebMock::API)

keys_file = File.expand_path("../keys", __FILE__)
keys = File.read(keys_file)

stub_request(:get, "https://github.com/user01.keys").
  to_return(:status => 200, :body => keys, :headers => {})

include_recipe "centos7_base::disable_selinux"
include_recipe "centos7_base::yum-cron"
include_recipe "centos7_base::users"
include_recipe "centos7_base::mailto"
include_recipe "centos7_base::enable_wheel"
include_recipe "centos7_base::sshd_config"
include_recipe "centos7_base::epel"

