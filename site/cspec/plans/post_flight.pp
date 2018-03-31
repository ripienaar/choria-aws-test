plan cspec::post_flight (
  Hash $ds,
) {
  notice("Performing post flight tasks")

  choria::run_playbook("mcollective_agent_puppet::enable",
    nodes   => choria::data("discovery.all_nodes", $ds)
  )
}
