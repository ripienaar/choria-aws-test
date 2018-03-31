plan cspec::post_flight (
  Hash $ds,
) {
  notice("===")
  notice("Performing post flight tasks")
  notice("===")

  choria::run_playbook("mcollective_agent_puppet::enable",
    nodes   => choria::data("discovery.all_nodes", $ds)
  )
}
