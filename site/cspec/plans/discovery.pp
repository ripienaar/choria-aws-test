plan cspec::discovery (
  Hash $ds,
  Boolean $fail_fast = false,
  String $report,
) {
  choria::data("discovery.fact_filter", $ds).each |$ff| {
    $args = {
      "all_nodes"         => choria::data("discovery.all_nodes", $ds),
      "mcollective_nodes" => choria::data("discovery.mcollective_nodes", $ds),
      "filtered_nodes"    => choria::data("discovery.filtered_nodes", $ds),
      "fact_filter"       => $ff,
      "fail_fast"         => $fail_fast,
      "report"            => $report,
    }

    choria::run_playbook("cspec::discovery::mc_method", $args)
    choria::run_playbook("cspec::discovery::choria_method", $args)
  }
}
