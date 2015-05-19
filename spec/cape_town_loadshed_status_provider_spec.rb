require 'spec_helper'
require 'webmock/rspec'

require 'lib/cape_town_loadshed_status_provider'

describe "Cape Town Loadshed Status Provider" do

  def compare_stage(got, want)
    expect(got.stage).to eq(want.stage)
  end

  describe "call City of Cape Town API" do
    it "calls http://www.capetown.gov.za/en/electricity/Pages/LoadShedding.aspx" do
      stub = stub_request(:get, "www.capetown.gov.za/en/electricity/Pages/LoadShedding.aspx")
      CapeTownLoadshedStatusProvider.get_status
      expect(stub).to have_been_requested
    end

    it "returns none on Net::HTTP exception" do
      expect(Net::HTTP).to receive(:start).and_throw("Exception!")
      compare_stage(CapeTownLoadshedStatusProvider.get_status, LoadsheddingStatus.none)
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
      @capetown_provider = CapeTownLoadshedStatusProvider.new(@connection)
    end

    it "defaults to none" do
      expect(@connection).to receive(:get_status_result).and_return("foobar")
      compare_stage(@capetown_provider.get_status, LoadsheddingStatus.none)
    end

    def valid_html(html_content)
      "<table><table><table><table><tr><td class='CityArticleTitle'>#{html_content}</td></tr></table></table></table></table>"
    end

    it "converts 'LOADSHEDDING HAS BEEN SUSPENDED UNTIL FURTHER NOTICE' to none" do
      expect(@connection).to receive(:get_status_result).and_return(valid_html("LOADSHEDDING HAS BEEN SUSPENDED UNTIL FURTHER NOTICE"))
      compare_stage(@capetown_provider.get_status, LoadsheddingStatus.none)
    end

    it "converts anything with suspend to none" do
      expect(@connection).to receive(:get_status_result).and_return(valid_html("LOADSHED IS suspended NOW"))
      compare_stage(@capetown_provider.get_status, LoadsheddingStatus.none)
    end

    it "converts 'LOADSHEDDING IS IN STAGE 1' to stage1" do
      expect(@connection).to receive(:get_status_result).and_return(valid_html("LOADSHEDDING IS IN STAGE 1"))
      compare_stage(@capetown_provider.get_status, LoadsheddingStatus.stage1)
    end

    it "converts anything without 'suspended' and with 'stage 1' to stage1" do
      expect(@connection).to receive(:get_status_result).and_return(valid_html("LOADSHEDDING IS ABOUTS STAGE 1 OR THERE SOMEwhere"))
      compare_stage(@capetown_provider.get_status, LoadsheddingStatus.stage1)
    end

    it "converts anything without 'suspended' and with 'stage1' to stage1" do
      expect(@connection).to receive(:get_status_result).and_return(valid_html("LOADSHEDDING IS ABOUTS stage1 OR THERE SOMEwhere"))
      compare_stage(@capetown_provider.get_status, LoadsheddingStatus.stage1)
    end

    it "converts anything without 'suspended' and with 'stage2' to stage2" do
      expect(@connection).to receive(:get_status_result).and_return(valid_html("LOADSHEDDING IS ABOUTS StAge2 OR THERE SOMEwhere"))
      compare_stage(@capetown_provider.get_status, LoadsheddingStatus.stage2)
    end

    it "converts anything without 'suspended' and with 'stage 3a' to stage3a" do
      expect(@connection).to receive(:get_status_result).and_return(valid_html("LOADSHEDDING IS ABOUTS StAge 3a OR THERE SOMEwhere"))
      compare_stage(@capetown_provider.get_status, LoadsheddingStatus.stage3a)
    end

    it "converts anything without 'suspended' and with 'stage3B' to stage3b" do
      expect(@connection).to receive(:get_status_result).and_return(valid_html("LOADSHEDDING IS ABOUTS StAge3B OR THERE SOMEwhere"))
      compare_stage(@capetown_provider.get_status, LoadsheddingStatus.stage3b)
    end


  end
end
