module PuppetX
  class Cspec
    class Suite
      def self.from_asserted_hash(description, fail_fast, report)
        new(description, fail_fast, report)
      end

      attr_reader :description, :fail_fast

      def initialize(description, fail_fast, report)
        @description = description
        @fail_fast = !!fail_fast
        @report = report
        @testcases = []
      end

      def puppet_file_line
        fl = Puppet::Pops::PuppetStack.stacktrace[0]

        [fl[0], fl[1]]
      end

      def outcome
        {
          "testsuite" => @description,
          "testcases" => @testcases,
          "file" => puppet_file_line[0],
          "line" => puppet_file_line[1],
          "success" => @testcases.all?{|t| t["success"]}
        }
      end

      def write_report
        report = []

        if File.exist?(@report)
          data = File.read(@report)
          begin
            report = JSON.parse(data)
          rescue
            Puppet.error("Loading previous report failed: %s", $!)
          end
        end

        report << outcome

        File.open(@report, "w") do |f|
          f.puts(JSON.pretty_generate(report))
        end
      end

      def run_suite
        Puppet.notice(">>>")
        Puppet.notice(">>> Starting test suite: %s" % [@description])
        Puppet.notice(">>>")

        begin
          yield(self)
        ensure
          write_report
        end


        Puppet.notice(">>>")
        Puppet.notice(">>> Completed test suite: %s" % [@description])
        Puppet.notice(">>>")
      end

      def it(description, &blk)
        require_relative "case"

        t = PuppetX::Cspec::Case.new(self, description)
        t.run(&blk)
      ensure
        @testcases << t.outcome
      end
    end
  end
end
