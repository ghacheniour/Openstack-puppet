SSH = 'ssh -A master@192.168.10.21'
desc "Run Puppet on ENV['CLIENT']"
task :apply do
client = ENV['CLIENT']
sh "git push"
sh "#{SSH} #{client} pull-updates"
end

