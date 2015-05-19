require 'spec_helper'
require 'webmock/rspec'

require 'lib/eskom_loadshed_status_provider'

describe "Eskom Loadshed Status Provider" do

  def compare_stage(got, want)
    expect(got.stage).to eq(want.stage)
  end

  describe "Eskom API" do
    it "calls http://loadshedding.eskom.co.za/LoadShedding/GetStatus" do
      stub = stub_request(:get, "loadshedding.eskom.co.za/LoadShedding/GetStatus")
      EskomLoadshedStatusProvider.get_status
      expect(stub).to have_been_requested
    end

    it "returns '0' on Net::HTTP exception" do
      expect(Net::HTTP).to receive(:start).and_throw("Exception!")
      compare_stage(EskomLoadshedStatusProvider.get_status, LoadsheddingStatus.none)
    end
  end

  describe "converting Eskom API to loadshed status values" do
    # 0 = no loadshedding
    # 1 = stage 1
    # 2 = stage 2
    # 3a = stage 3a
    # 3b = stage 3b
    before :each do
      @connection = double("Connection")
      @eskom_provider = EskomLoadshedStatusProvider.new(@connection)
    end

    it "defaults to none" do
      expect(@connection).to receive(:get_status_result).and_return("foobar")
      compare_stage(@eskom_provider.get_status, LoadsheddingStatus.none)
    end

    it "converts 1 to none" do
      expect(@connection).to receive(:get_status_result).and_return("1")
      compare_stage(@eskom_provider.get_status, LoadsheddingStatus.none)
    end

    it "converts 2 to stage1" do
      expect(@connection).to receive(:get_status_result).and_return("2")
      compare_stage(@eskom_provider.get_status, LoadsheddingStatus.stage1)
    end

    it "converts 3 to stage2" do
      expect(@connection).to receive(:get_status_result).and_return("3")
      compare_stage(@eskom_provider.get_status, LoadsheddingStatus.stage2)
    end

    it "converts 4 to stage3a" do
      expect(@connection).to receive(:get_status_result).and_return("4")
      compare_stage(@eskom_provider.get_status, LoadsheddingStatus.stage3a)
    end

    it "converts 5 to stage3b" do
      expect(@connection).to receive(:get_status_result).and_return("5")
      compare_stage(@eskom_provider.get_status, LoadsheddingStatus.stage3b)
    end

  end
end
