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

  choria::run_playbook("cspec::pre_flight", ds => $ds)

  choria::run_playbook("cspec::perform_tests", _catch_errors => true,
    ds => $ds,
    fail_fast => $fail_fast,
    report => $report
  )
    .choria::on_error |$err| {
      err("Test suite failed with a critical error: ${err.message}")
    }

  choria::run_playbook("cspec::post_flight", ds => $ds)

  cspec::summarize_report($report)
}
