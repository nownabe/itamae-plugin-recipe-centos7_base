describe package("openssh-server") do
  it { should be_installed }
end

describe service("sshd") do
  it { should be_running }
  it { should be_enabled }
end

describe file("/etc/ssh/sshd_config") do
  it { should be_file }
  its(:content) { should match /^PasswordAuthentication no$/ }
  its(:content) { should_not match /^PasswordAuthentication yes/ }
  its(:content) { should match /^PermitEmptyPasswords no$/ }
  its(:content) { should_not match /^PermitEmptyPasswords yes/ }
  its(:content) { should match /^PermitRootLogin no$/ }
  its(:content) { should_not match /^PermitRootLogin yes/ }
end
