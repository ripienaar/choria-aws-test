Puppet::Functions.create_function(:"cspec::summarize_report") do
  dispatch :handler do
    param "String", :report
  end

  def handler(report)
    return({"error" => "Report %s not found" % report}) unless File.exist?(report)

    data = JSON.parse(File.read(report))

    suites = data.map do |suite|
      {
        "name" => suite["testsuite"],
        "cases" => suite["testcases"].size,
        "success" => suite["success"],
      }
    end

    {
       "testsuites" => suites,
       "success" => data.all? {|d| d["success"] },
    }
  end
end
