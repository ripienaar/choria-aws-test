plan cspec::discovery::mc_method (
  Array[String] $all_nodes,
  Array[String] $mcollective_nodes,
  Array[String] $filtered_nodes,
  String $fact_filter,
  String $report,
  Boolean $fail_fast = false
) {
  choria::run_playbook("cspec::discovery::test",
    method            => "mc",
    all_nodes         => $all_nodes,
    mcollective_nodes => $mcollective_nodes,
    filtered_nodes    => $filtered_nodes,
    fact_filter       => $fact_filter,
    fail_fast         => $fail_fast,
    report            => $report
  )
}
