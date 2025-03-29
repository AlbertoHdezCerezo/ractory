module Ractory
  # A +ractory+ +ProductionLine+ defines a work flow designed to be
  # executed in para
  class ProductionLine
    class InvalidRunModeError < StandardError; end

    attr_reader :workers

    def initialize(workers:)
      @workers = workers
    end

    # Runs collection of +Ractory::Workers+ according to the +ProductionLine+ configuration
    def run(mode:)
      case mode
      when :sequential then run_sequentially
      when :parallel then run_parallel
      else
        raise InvalidRunModeError, <<-MSG
          Invalid run mode: #{mode} for Ractory::ProductionLine.
          Valid run modes are :sequential and :parallel
        MSG
      end
    end

    private def run_sequentially
      workers.each(&:perform)
    end

    private def run_parallel
      workers.map do |worker|
        Ractor.new(worker) do |w|
          w.perform
        end
      end.each(&:take)
    end
  end
end
