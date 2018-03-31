plan cspec::discovery::test (
  Enum["mc", "choria"] $method,
  Array[String] $all_nodes,
  Array[String] $mcollective_nodes,
  Array[String] $filtered_nodes,
  String $fact_filter,
  String $report,
  Boolean $fail_fast = false,
) {
  cspec::suite("${method} discovery method", $fail_fast, $report) |$suite| {
    $suite.it("Should support a basic discovery") |$t| {
      $found = choria::discover(
        "discovery_method" => $method,
      )

      $t.assert_equal($found.sort, $all_nodes.sort)
    }

    $suite.it("Should support testing connectivity") |$t| {
      $found = choria::discover(
        "discovery_method" => $method,
        "test"             => true,
      )

      $t.assert_equal($found.sort, $all_nodes.sort)
    }

    $suite.it("Should support fact filters") |$t| {
      $found = choria::discover(
        "discovery_method" => $method,
        "facts"            => [$fact_filter]
      )

      $t.assert_equal($found.sort, $filtered_nodes.sort)
    }

    $suite.it("Should support class filters") |$t| {
      $found = choria::discover(
        "discovery_method" => $method,
        "classes"          => ["mcollective"]
      )

      $t.assert_equal($found.sort, $mcollective_nodes.sort)
    }
  }

  undef
}

