describe file("/etc/pam.d/su") do
  it { should be_file }
  its(:content) { should match /^auth\s+required\s+pam_wheel\.so\s+use_uid$/ }
end

