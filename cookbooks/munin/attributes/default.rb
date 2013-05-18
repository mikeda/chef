default[:munin][:server][:servers] = [
  { hostname: 'munin01', address: '127.0.0.1'},
  { hostname: 'test01', address: '192.168.1.61'},
  { hostname: 'test02', address: '192.168.1.62'},
  { hostname: 'test03', address: '192.168.1.63'},
  { hostname: 'proxy02', address: '192.168.1.111'},
]
default[:munin][:server][:links] = {
  'snmp_vyatta01_cpuload'  => 'snmp__cpuload',
  'snmp_vyatta01_if_2'     => 'snmp__if_',
  'snmp_vyatta01_if_3'     => 'snmp__if_',
  'snmp_vyatta01_if_err_2' => 'snmp__if_err_',
  'snmp_vyatta01_if_err_3' => 'snmp__if_err_',
}
