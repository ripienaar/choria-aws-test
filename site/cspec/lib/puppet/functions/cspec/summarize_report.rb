Puppet::Functions.create_function(:"cspec::summarize_report") do
  dispatch :handler do
    param "String", :report
  end

  def handler(report)
    return {"error" => "Report %s not found" % report} unless File.exist?(report)

    data = JSON.parse(File.read(report))
    data.delete("testcases")

    data
  end
end
