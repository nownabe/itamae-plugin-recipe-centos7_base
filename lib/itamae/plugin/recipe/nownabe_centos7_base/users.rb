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

  # home directory
  home_dir = if opt["home-dir"].present?
    opt["home-dir"]
  elsif opt["base-dir"].present?
    "#{opt["base-dir"]}/#{user}"
  else
    "/home/#{user}"
  end

  authorized_keys_file = "#{home_dir}/.ssh/authorized_keys"
  does_put_authorized_keys = opt["authorized_keys"].present?
  does_put_authorized_keys ||= ( opt["authorized_keys_file"].present? and 
                                 File.exist?(File.expand_path(opt["authorized_keys_file"])) )

  execute "add user #{user}" do
    command cmd.join(" ")
    not_if "id #{user}"
    if does_put_authorized_keys 
      notifies :create, "directory[#{home_dir}/.ssh]"
      notifies :create, "file[#{authorized_keys_file}]"
    end
  end
 
  if does_put_authorized_keys
    directory "#{home_dir}/.ssh" do
      owner user
      group opt["gid"] || user
      mode "0700"
      action :nothing
    end
 
    file authorized_keys_file do
      if opt["authorized_keys"].present?
        content opt["authorized_keys"]
      else
        content_file File.expand_path(opt["authorized_keys_file"])
      end
      owner user
      group opt["gid"] || user
      mode "0600"
      action :nothing
    end
  end

end
