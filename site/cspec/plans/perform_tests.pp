plan cspec::perform_tests (
  Boolean $fail_fast = false,
  Stdlib::Absolutepath $report,
) {
  $suites = choria::data("suites", $ds)
  notice(sprintf("Running test suites: %s", $suites.join(", ")))

  choria::data("suites", $ds).each |$suite| {
    choria::run_playbook($suite,
      ds => $ds,
      fail_fast => $fail_fast,
      report => $report
    )
  }
}
