Puppet::DataTypes.create_type("Cspec::Case") do
  interface <<-PUPPET
    attributes => {
      "description" => String,
      "suite" => Cspec::Suite
    },

    functions => {
      assert_equal => Callable[[Any, Any], Boolean],
      assert_task_success => Callable[[Choria::TaskResults], Boolean],
      assert_task_data_equals => Callable[[Choria::TaskResult, Any, Any], Boolean]
    }
  PUPPET

  load_file "puppet_x/cspec/case"

  implementation_class PuppetX::Cspec::Case
end
