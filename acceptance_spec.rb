require('rspec')
require('./region_repository')
require('./region_selector')


describe "Acceptance" do
  it "returns zone 5 for Claremont" do
    regions = RegionRepository.all
    selector = RegionSelector.new(regions)
    region = selector.my_region("-33.980376","18.463699")

    expect(region.zone).to eq "5"
  end

  it "returns nothing for London" do
    regions = RegionRepository.all
    selector = RegionSelector.new(regions)
    region = selector.my_region("51.5286416","-0.1015987")

    expect(region.zone).to eq ""
  end

end