plan cspec::choria (
  Hash $ds,
  String $report,
  Boolean $fail_fast = false,
) {
  $version = choria::data("choria.version", $ds)
  $nodes = choria::data("discovery.all_nodes", $ds)

  cspec::suite("choria tests", $fail_fast, $report) |$suite| {
    $suite.it("Should all run choria version ${version}") |$t| {
      $results = choria::task("mcollective", _catch_errors => true,
        "action" => "choria_util.info",
        "nodes" => $nodes,
        "silent" => true
      )

      $t.assert_task_success($results)

      $results.results.each |$r| {
        $t.assert_task_data_equals($r, $r["data"]["choria_version"], $version)
      }
    }
  }

  undef
}
