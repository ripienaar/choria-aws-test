plan cspec::run_suites (
  Hash $ds,
  Boolean $fail_fast = false,
  Stdlib::Absolutepath $report,
) {
  $suites = choria::data("suites", $ds)
  notice(sprintf("Running test suites:\n\t%s", $suites.join("\n\t")))

  choria::data("suites", $ds).each |$suite| {
    choria::run_playbook($suite,
      ds => $ds,
      fail_fast => $fail_fast,
      report => $report
    )
  }
}
