plan cspec::pre_flight (
  Hash $ds,
) {
  notice("===")
  notice("Performing pre flight tasks")
  notice("===")

  $nodes = choria::data("discovery.all_nodes", $ds)

  choria::task(
    action     => "puppet.runonce",
    nodes      => $nodes,
    silent     => true,
    properties => {
      "force"  => true
    }
  )

  choria::task(
    "action"     => "puppet.disable",
    "nodes"      => $nodes,
    "fail_ok"    => true,
    "silent"     => true,
    "pre_sleep"  => 5,
    "properties" => {
       "message" => "Disabled during Choria integration tests"
    }
  )

  choria::task(
    "action"    => "puppet.status",
    "nodes"     => $nodes,
    "assert"    => "idling=true",
    "tries"     => 10,
    "try_sleep" => 20,
    "silent"    => true,
    "pre_sleep" => 5
  )
}
