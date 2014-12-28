require 'spec_helper'

describe command("getenforce") do
  its(:stdout) { should match "Permissive" }
end

describe file("/etc/selinux/config") do
  it { should be_file }
  its(:content) { should match /^SELINUX=disabled/ }
  its(:content) { should_not match /^SELINUX=enforcing/ }
end

