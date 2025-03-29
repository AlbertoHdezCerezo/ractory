module Ractory
  # A +ractory+ +Worker+ is a class specializer on performing a
  # specific task. It works as jobs, but with a special interface
  # designed to be executed in +Ractors+
  class Worker
    def perform
      raise NotImplementedError, "You must implement Ractory::Worker perform method"
    end
  end
end
