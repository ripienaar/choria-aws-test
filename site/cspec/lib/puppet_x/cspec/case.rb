module PuppetX
  class Cspec
    class Case
      def self.from_asserted_hash(suite, description)
        new(suite, description)
      end

      def initialize(suite, description)
        @suite = suite
        @description = description
        @assertions = []
        @start_location = puppet_file_line
      end

      def assert_task_data_equals(result, left, right)
        if left == right
          success("assert_task_data_equals", "%s success" % result.host)

          return true
        end

        failure("assert_equal: %s" % result.host, "%s\n\n\tis not equal to\n\n %s" % [left, right])

        return false
      end

      def assert_task_success(results)
        if results.error_set.empty?
          success("assert_task_success:", "%d OK results" % results.count)
          return true
        end

        failure("assert_task_success:", "%d failures" % [results.error_set.count])

        return false
      end

      def assert_equal(left, right)
        if left == right
          success("assert_equal", "values matches")

          return true
        end

        failure("assert_equal", "%s\n\n\tis not equal to\n\n %s" % [left, right])

        return false
      end

      def puppet_file_line
        fl = Puppet::Pops::PuppetStack.stacktrace[0]

        [fl[0], fl[1]]
      end

      def success(what, message)
        @assertions << {
          "success" => true,
          "kind" => what,
          "file" => puppet_file_line[0],
          "line" => puppet_file_line[1],
          "message" => message
        }

        Puppet.notice("✔︎ %s: %s" % [what, message])
      end

      def failure(what, message)
        @assertions << {
          "success" => false,
          "kind" => what,
          "file" => puppet_file_line[0],
          "line" => puppet_file_line[1],
          "message" => message
        }

        Puppet.err("✘ %s: %s" % [what, @description])
        Puppet.err(message)

        raise(Puppet::Error, "Test case %s fast failed: %s" % [@description, what]) if @suite.fail_fast
      end

      def outcome
        {
          "testcase" => @description,
          "assertions" => @assertions,
          "success" => @assertions.all? {|a| a["success"]},
          "file" => @start_location[0],
          "line" => @start_location[1]
        }
      end

      def run
        Puppet.notice("==== Test case: %s" % [@description])

        yield(self)

        success("testcase", @description)
      end
    end
  end
end

