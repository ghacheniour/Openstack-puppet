REPO = 'git@github.com:ghacheniour/project.git'
SSH = 'ssh -A -i /root/.ssh/pub_key.pem -l master'
desc "Run Puppet on ENV['CLIENT']"
task :apply do
client = ENV['CLIENT']
sh "git push"
sh "#{SSH} #{client} pull-updates"
end

desc "Bootstrap Puppet on ENV['CLIENT'] with
hostname ENV['HOSTNAME']"
task :bootstrap do
client = ENV['CLIENT']
hostname = ENV['HOSTNAME'] || client
commands = <<BOOTSTRAP
sudo hostname #{hostname} && \
sudo su - c 'echo #{hostname} >/etc/hostname' && \
wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb && \
sudo dpkg -i puppetlabs-release-precise.deb && \
sudo apt-get update && sudo apt-get -y install git
puppet && \
git clone #{REPO} puppet && \
sudo puppet apply --modulepath=/root/puppet/modules /root/puppet/manifests/site.pp
BOOTSTRAP
sh "#{SSH} #{client} '#{commands}'"
end

