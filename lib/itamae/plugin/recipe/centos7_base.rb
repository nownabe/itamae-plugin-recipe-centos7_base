require "itamae/plugin/recipe/centos7_base/version"

include_recipe "centos7_base::disable_selinux"
include_recipe "centos7_base::yum-cron"
include_recipe "centos7_base::users"
include_recipe "centos7_base::mailto"
include_recipe "centos7_base::enable_wheel"
include_recipe "centos7_base::sshd_config"
include_recipe "centos7_base::epel"
