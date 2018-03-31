Puppet::DataTypes.create_type("Cspec::Suite") do
  interface <<-PUPPET
    attributes => {
      "description" => String,
      "fail_fast" => Boolean,
      "report" => String
    },

    functions => {
      it => Callable[[String, Callable[Cspec::Case]], Any],
      outcome => Callable[[], Hash]
    }
  PUPPET

  load_file "puppet_x/cspec/suite"

  implementation_class PuppetX::Cspec::Suite
end
