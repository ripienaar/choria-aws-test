plan cspec::agents::process (
  Hash $ds,
  String $report,
  Boolean $fail_fast = false,
) {
  $nodes = choria::data("discovery.all_nodes", $ds)

  cspec::suite("process agent tests", $fail_fast, $report) |$suite| {
    # I'd like to test the data contains actual correct data but this
    # data is not JSON safe and so not compatible with puppet at all
    # something to fix in the agent
    $suite.it("Should get process list") |$t| {
      $results = choria::task("mcollective", _catch_errors => true,
        "action" => "process.list",
        "nodes" => $nodes,
        "silent" => true,
        "properties" => {
          "pattern" => "mcollectived"
        }
      )

      $t.assert_task_success($results)
    }
  }

  undef
}
