%w(nrpe nagios-plugins-all).each do |pkg|
  package pkg
end

service "nrpe" do
  supports :status => true, :reload => true
  action [ :enable, :start ]
end

template '/etc/nagios/nrpe.cfg' do
  notifies :reload, resources(:service => "nrpe")
end
