
require 'spec_helper'

#Set my instance information in variables for visibility

#Get the region. Only AZ is defined in host_inventory so we trunck the last caracters to get the region
region = host_inventory['ec2']['placement']['availability-zone'].slice(0..-2)
publichostname = host_inventory['ec2']['public-hostname']

#Check if server listens to Jenkins associated port
describe port(8080) do
  it { should be_listening }
end

#Check if jenkins is running
describe service('jenkins') do
  it { should be_enabled }
end

#Check if hsproject was extracted properly, in the right directory
describe file('/var/lib/jenkins/jobs/hsproject') do
  it { should be_directory }
end


#Check if the region was changed in the configuration file
describe file('/var/lib/jenkins/jobs/hsproject/config.xml') do
  it { should contain region}
end

#Check if the server is reachable using his public dns name
describe host(publichostname) do
  it { should be_reachable }
end
