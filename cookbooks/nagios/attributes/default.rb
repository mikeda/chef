default[:nagios][:server][:servers] = [
  { host_name: 'nagios01', address: '192.168.1.125', hostgroups: %w(linux httpd)},
  { host_name: 'munin01', address: '192.168.1.124', hostgroups: %w(linux httpd)},
  { host_name: 'test01', address: '192.168.1.61', hostgroups: %w(linux)},
  { host_name: 'test02', address: '192.168.1.62', hostgroups: %w(linux)},
  { host_name: 'proxy02', address: '192.168.1.111', hostgroups: %w(linux nginx)},
]
