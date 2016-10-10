require 'spec_helper'

describe package('httpd'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('apache2'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe package('mysql-server'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end


describe service('httpd'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe service('apache2'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe service('mysql'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end


describe service('org.apache.httpd'), :if => os[:family] == 'darwin' do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe port(3306) do
  it { should be_listening }
end

describe command('ls -al /var') do
  its(:stdout) { should match /www/ }
end

describe command('ls /var/www/html') do
  its(:exit_status) { should eq 0 }
end

describe command('apachectl -M') do
  its(:stdout) { should contain('php5_module') }
end

describe file('/var/www/html/index.html') do
  it { should be_file }
end

describe file('/etc/apache2/apache2.conf') do
  it { should contain 'KeepAliveTimeout 5' }
end

describe file('/var/www/html/index.html') do
  it { should be_owned_by 'root' }
end


# negative

describe file('/var/foo') do
  it { should_not exist }
end


describe port(8080) do
  it { should_not be_listening }
end

describe file('/var/www/html/bestbabysitters.html') do
  it { should_not contain 'harambe' }
end

