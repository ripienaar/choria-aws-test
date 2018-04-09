plan cspec::agents::filemgr (
  Hash $ds,
  String $report,
  Boolean $fail_fast = false,
) {
  $nodes = choria::data("discovery.all_nodes", $ds)

  cspec::suite("filemgr agent tests", $fail_fast, $report) |$suite| {
    $suite.it("Should get file details") |$t| {
      $results = choria::task("mcollective", _catch_errors => true,
        "action" => "filemgr.status",
        "nodes" => $nodes,
        "silent" => true,
        "fact_filter" => ["kernel=Linux"],
        "properties" => {
          "file" => "/etc/hosts"
        }
      )

      $t.assert_task_success($results)

      $results.each |$result| {
        $t.assert_task_data_equals($result, $result["data"]["present"], 1)
      }
    }

    $suite.it("Should support touch") |$t| {
      $fname = sprintf("/tmp/filemgr.%s", strftime(Timestamp(), "%s"))

      $r1 = choria::task("mcollective", _catch_errors => true,
        "action" => "filemgr.touch",
        "nodes" => $nodes,
        "silent" => true,
        "fact_filter" => ["kernel=Linux"],
        "fail_ok" => true,
        "properties" => {
          "file" => $fname
        }
      )

      $t.assert_task_success($r1)

      $r2 = choria::task("mcollective", _catch_errors => true,
        "action" => "filemgr.status",
        "nodes" => $nodes,
        "silent" => true,
        "fact_filter" => ["kernel=Linux"],
        "properties" => {
          "file" => $fname
        }
      )

      $t.assert_task_success($r2)

      $r2.each |$result| {
        $t.assert_task_data_equals($result, $result["data"]["present"], 1)
      }
    }
  }

  undef
}

