name "cassandra_test_cluster01"
description "Cassandra Test Cluster01"
run_list "recipe[cassandra]"
default_attributes :cassandra => {
  :cluster_name => 'cassandra_test_cluster01',
  :seeds => ['192.168.1.121'],
  :initial_token => {
    'cassandra01' => 0,
    'cassandra02' => (2**127 / 4) * 2,
    'cassandra03' => (2**127 / 4) * 3,
  }
}
