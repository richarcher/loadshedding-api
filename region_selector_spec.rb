require('rspec')
require('./region_selector')
require('./region')


describe "region" do
  def create_region(polygons)
    Region.new("", "", polygons)
  end

  it "returns a null object when there are no polygons" do
    selector = RegionSelector.new([])
    region = selector.my_region(10,10)
    expect(region).to be_a_kind_of(NullRegion)
  end

  it "returns a null object when lat/long is outside a polygon" do
    region = create_region([[[0,0], [10, 0], [10, 10], [0, 10]]])
    selector = RegionSelector.new([region])
    expect(selector.my_region(20,20)).to be_a_kind_of(NullRegion)
  end

  it "returns a loadshedding object when lag/long is inside a polygon" do
    region = create_region([[[0,0], [10, 0], [10, 10], [0, 10]]])
    selector = RegionSelector.new([region])
    expect(selector.my_region(5,5)).to be_a_kind_of(Region)
    expect(selector.my_region(5,5)).to eq(region)
  end

  it "returns the region given multiple polygons" do
    poly1 = [[0,0], [10, 0], [10, 10], [0, 10]]
    poly2 = [[20,20], [30, 20], [30, 30], [20, 30]]
    region = create_region([poly1, poly2])
    selector = RegionSelector.new([region])
    expect(selector.my_region(25, 25)).to eq(region)
  end

  it "returns the correct region given multiple regions" do
    region1 = create_region([[[0,0], [10, 0], [10, 10], [0, 10]]])
    region2 = create_region([[[20,20], [30, 20], [30, 30], [20, 30]]])
    selector = RegionSelector.new([region1, region2])
    expect(selector.my_region(25, 25)).to eq(region2)
  end

end