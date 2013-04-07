include_recipe 'munin::client'

package 'perl-Cache-Cache'

types = %w(
  commands
  connections
  innodb_rows
  innodb_tnx
  qcache
  replication
  select_types
  slow
  sorts
  table_locks
  tmp_tables
)

types.each do |type|
  link "mysql_#{type}" do
    owner 'munin'
    group 'munin'
    target_file "/etc/munin/plugins/mysql_#{type}"
    to "/usr/share/munin/plugins/mysql_"
    notifies :restart, resources(:service => "munin-node")
  end
end
