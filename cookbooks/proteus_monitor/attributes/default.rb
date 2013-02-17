exec_user = 'sysadmin'
base_dir  = '/home/sysadmin/proteus_monitor'

default[:proteus_monitor] = {
  exec_user: 'sysadmin',
  base_dir:  '/home/sysadmin/proteus_monitor',
}

default[:proteus_monitor][:nodejs] = {
  version:     "0.8.20",
  install_dir: "#{base_dir}/node"
}

default[:proteus_monitor][:server] = {
  repository:  "https://github.com/ameba-proteus/proteus-monitor-server.git",
  install_dir: "#{base_dir}/server",
  host: '192.168.1.118',
  port: '3333'

}

default[:proteus_monitor][:agent] = {
  repository:  "https://github.com/ameba-proteus/proteus-monitor-agent.git",
  install_dir: "#{base_dir}/agent",
  config:      "#{base_dir}/agent.json",
  group:       "default",
  plugins: {
    stat: {},
    ps: {
      'agent' => 'node.+agent\\.js'
    }
  }
}
