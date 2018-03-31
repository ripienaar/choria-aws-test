plan cspec::suite (
  Boolean $fail_fast = false,
  Stdlib::Absolutepath $report,
  String $data
) {
  $ds = {
    "type"   => "file",
    "file"   => $data,
    "format" => "yaml",
    "create" => true
  }

  cspec::clear_report($report)

  $suites = choria::data("suites", $ds)

  choria::run_playbook("cspec::pre_flight", ds => $ds)

  notice(sprintf("Running test suites: %s", $suites.join(", ")))

  choria::data("suites", $ds).each |$suite| {
    choria::run_playbook($suite,
      ds => $ds,
      fail_fast => $fail_fast,
      report => $report
    )
  }

  choria::run_playbook("cspec::pre_flight", ds => $ds)

  undef
}
