Puppet::Functions.create_function(:"cspec::clear_report") do
  dispatch :handler do
    param "String", :report
  end

  def handler(report)
    if File.exist?(report)
      File.unlink(report)
    end
  end
end
