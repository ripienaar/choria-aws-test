plan cspec::agents::nettest (
  Hash $ds,
  String $report,
  Boolean $fail_fast = false,
) {
  $nodes = choria::data("discovery.all_nodes", $ds)

  cspec::suite("nettest agent tests", $fail_fast, $report) |$suite| {
    $suite.it("Should be able to connect to a node") |$t| {
      $results = choria::task("mcollective", _catch_errors => true,
        "action" => "nettest.connect",
        "nodes" => $nodes,
        "silent" => true,
        "properties" => {
          "fqdn" => choria::data("nettest.fqdn", $ds),
          "port" => choria::data("nettest.port", $ds),
        }
      )

      $t.assert_task_success($results)

      $results.results.each |$r| {
        $t.assert_task_data_equals($r, $r["data"]["connect"], true)
        $t.assert_task_data_equals($r, $r["data"]["connect_status"], "Connected")
      }
    }

    $suite.it("Should be able to ping a node") |$t| {
      $results = choria::task("mcollective", _catch_errors => true,
        "action" => "nettest.ping",
        "nodes" => $nodes,
        "silent" => true,
        "properties" => {
          "fqdn" => choria::data("nettest.fqdn", $ds),
        }
      )

      $t.assert_task_success($results)

      $results.results.each |$r| {
        $t.assert_task_data_equals($r, "RTT" in $r["data"], true)
      }
    }
  }

  undef
}
