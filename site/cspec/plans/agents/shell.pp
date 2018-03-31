plan cspec::agents::shell (
  Hash $ds,
  String $report,
  Boolean $fail_fast = false,
) {
  $nodes = choria::data("discovery.all_nodes", $ds)

  cspec::suite("shell agent tests", $fail_fast, $report) |$suite| {
    $suite.it("Should be able to execute commands") |$t| {
      $results = choria::task("mcollective", _catch_errors => true,
        "action" => "shell.run",
        "nodes" => $nodes,
        "properties" => {
          "command" => "echo cspec test"
        }
      )

      $t.assert_task_success($results)

      $results.results.each |$r| {
        $t.assert_task_data_equals($r, $r["data"]["success"], true)
        $t.assert_task_data_equals($r, $r["data"]["stdout"], "cspec test\n")
        $t.assert_task_data_equals($r, $r["data"]["stderr"], "")
      }
    }
  }

  undef
}
