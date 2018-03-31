plan cspec::pre_flight (
  Hash $ds,
) {
  choria::task(
    action       => "puppet.runonce",
    nodes        => choria::data("discovery.all_nodes", $ds),
    properties   => {
      "force"    => true
    }
  )

  choria::run_playbook("mcollective_agent_puppet::disable_and_wait",
    nodes   => choria::data("discovery.all_nodes", $ds),
    message => "Performing Choria integration tests"
  )
}
