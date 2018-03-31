Puppet::Functions.create_function(:"cspec::suite") do
  dispatch :handler do
    param "String", :description
    param "Boolean", :fail_fast
    param "String", :report

    block_param

    return_type "Cspec::Suite"
  end

  def handler(description, fail_fast, report, &blk)
    suite = PuppetX::Cspec::Suite.new(description, fail_fast, report)

    suite.run_suite(&blk)
    suite
  end
end
