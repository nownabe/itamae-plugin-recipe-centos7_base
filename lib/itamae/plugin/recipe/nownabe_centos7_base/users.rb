require 'active_support/core_ext/object/blank'
require 'shellwords'

ALLOW_USERADD_OPTIONS = %w(
  base-dir home-dir defaults inactive gid
  groups skel key no-log-init create-home
  no-user-group non-unique password system
  root shell iud user-group user-group
  selinux-user
)

( (node[:base] || {})[:users] || {}).each do |user, opt|
  
  # useradd command
  cmd = ["useradd"]

  useradd_options = opt.keys.select { |o| ALLOW_USERADD_OPTIONS.include?(o) }
  useradd_options.each do |uo|
    uo_str = "--#{uo}"
    uo_str << " #{Shellwords.escape(opt[uo])}" if !opt[uo].blank?
    cmd << uo_str
  end
  
  cmd << "#{user}"
  
  execute "add user #{user}" do
    command cmd.join(" ")
    not_if "id #{user}"
    if opt["authorized_keys"].present? or
       opt["authorized_keys_file"].present? and File.exist?(opt["authorized_keys_file"])

      notifies :create, "file[make authorized_keys]"
    end
  end
 
  home_dir = if opt["home-dir"].present?
    opt["home-dir"]
  elsif opt["base-dir"].present?
    "#{opt["base-dir"]}/#{user}"
  else
    "/home/#{user}"
  end

  directory "#{home_dir}/.ssh" do
    owner user
    group opt["gid"] || user
    mode "0700"
  end

  file "#{home_dir}/.ssh/authorized_keys" do
    if opt["authorized_keys"].present?
      content opt["authorized_keys"]
    else
      content_file opt["authorized_keys_file"]
    end
    owner user
    group opt["gid"] || user
    mode "0600"
    action :nothing
  end

end
