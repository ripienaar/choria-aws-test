plan cspec::suite (
  Boolean $fail_fast = false,
  Boolean $pre_post = true,
  Stdlib::Absolutepath $report,
  String $data
) {
  $ds = {
    "type"   => "file",
    "file"   => $data,
    "format" => "yaml"
  }

  cspec::clear_report($report)

  if $pre_post {
    choria::run_playbook("cspec::pre_flight", ds => $ds)
  }

  choria::run_playbook("cspec::run_suites", _catch_errors => true,
    ds => $ds,
    fail_fast => $fail_fast,
    report => $report
  )
    .choria::on_error |$err| {
      err("Test suite failed with a critical error: ${err.message}")
    }

  if $pre_post {
    choria::run_playbook("cspec::post_flight", ds => $ds)
  }

  cspec::summarize_report($report)
}
