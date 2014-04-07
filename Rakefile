SSH = 'ssh -A -i /root/master.pem -l master'
desc "Run Puppet on ENV['CLIENT']"
task :apply do
client = ENV['CLIENT']
sh "git push"
sh "#{SSH} #{client} pull-updates"
end

