# frozen_string_literal: true
require "test/test_helper"

class ATestWorker < Ractory::Worker
  def perform
    sleep 0.1
  end
end

class TestProductionLine < Ractory::ProductionLine
end

class AnotherTestWorker < Ractory::Worker
  def perform
    sleep 0.1
  end
end

describe Ractory::ProductionLine do
  before do
    @production_line = TestProductionLine.new(workers: [ATestWorker.new, AnotherTestWorker.new],)
  end

  describe "#run" do
    it "if called with sequential mode, run workers sequentially" do
      start_time = Time.now
      @production_line.run(mode: :sequential)
      end_time = Time.now
      assert_in_delta 0.2, end_time - start_time, 0.1
    end

    it "if called with parallel mode, run workers in parallel" do
      start_time = Time.now
      @production_line.run(mode: :parallel)
      end_time = Time.now
      assert_in_delta 0.1, end_time - start_time, 0.1
    end
  end
end
