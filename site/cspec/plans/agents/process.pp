plan cspec::agents::process (
  Hash $ds,
  String $report,
  Boolean $fail_fast = false,
) {
  $nodes = choria::data("discovery.all_nodes", $ds)

  cspec::suite("process agent tests", $fail_fast, $report) |$suite| {
    $suite.it("Should get process list") |$t| {
      $results = choria::task("mcollective", _catch_errors => true,
        "action" => "process.list",
        "nodes" => $nodes,
        "silent" => true,
        "fact_filter" => ["kernel=Linux"],
        "properties" => {
          "pattern" => "mcollectived"
        }
      )

      $t.assert_task_success($results)

      $results.each |$result| {
        $t.assert_task_data_equals($result, $result["data"]["pslist"].length > 0, true)
        $t.assert_task_data_equals($result, $result["data"]["pslist"][0]["cmdline"] =~ /mcollectived/, true)
      }
    }
  }

  undef
}
