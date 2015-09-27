template "/etc/aliases" do
  source File.expand_path("../templates/aliases.erb", __FILE__)
  owner "root"
  group "root"
  mode "640"
  variables(aliases: node[:base][:mailto])
  notifies :run, "execute[newaliases]"
end

execute "newaliases" do
  command "newaliases"
  action :nothing
end
