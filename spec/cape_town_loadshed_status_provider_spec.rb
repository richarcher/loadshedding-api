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

    it "defaults to none" do
      expect(CapeTownLoadshedStatusProvider).to receive(:get_capetown_status_page).and_return("foobar")
      compare_stage(CapeTownLoadshedStatusProvider.get_status, LoadsheddingStatus.none)
    end

    def valid_html(html_content)
      "<table><table><table><table><tr><td class='CityArticleTitle'>#{html_content}</td></tr></table></table></table></table>"
    end

    it "converts 'LOADSHEDDING HAS BEEN SUSPENDED UNTIL FURTHER NOTICE' to none" do
      expect(CapeTownLoadshedStatusProvider).to receive(:get_capetown_status_page).and_return(valid_html("LOADSHEDDING HAS BEEN SUSPENDED UNTIL FURTHER NOTICE"))
      compare_stage(CapeTownLoadshedStatusProvider.get_status, LoadsheddingStatus.none)
    end

    it "converts 'LOADSHEDDING IS IN STAGE 1' to stage1" do
      expect(CapeTownLoadshedStatusProvider).to receive(:get_capetown_status_page).and_return(valid_html("LOADSHEDDING IS IN STAGE 1"))
      compare_stage(CapeTownLoadshedStatusProvider.get_status, LoadsheddingStatus.stage1)
    end

    #it "converts 3 to stage2" do
      #expect(CapeTownLoadshedStatusProvider).to receive(:get_capetown_status_page).and_return("3")
      #compare_stage(CapeTownLoadshedStatusProvider.get_status, LoadsheddingStatus.stage2)
    #end

    #it "converts 4 to stage3a" do
      #expect(CapeTownLoadshedStatusProvider).to receive(:get_capetown_status_page).and_return("4")
      #compare_stage(CapeTownLoadshedStatusProvider.get_status, LoadsheddingStatus.stage3a)
    #end

    #it "converts 5 to stage3b" do
      #expect(CapeTownLoadshedStatusProvider).to receive(:get_capetown_status_page).and_return("5")
      #compare_stage(CapeTownLoadshedStatusProvider.get_status, LoadsheddingStatus.stage3b)
    #end

  end
end
