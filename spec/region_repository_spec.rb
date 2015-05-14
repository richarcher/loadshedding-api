require('spec_helper')
require('lib/region_repository')
require('lib/region_polygon')

describe "region repository" do
  it "loads all regions" do
    expect(RegionRepository.all.size).to eq(22)
  end

  it "returns a region object" do
    expect(RegionRepository.all.first).to be_a_kind_of(Region)
  end

  it "return a Cape Town region" do
    expect(RegionRepository.all.first.name).to eq("Cape Town")
  end

  it "return a Cape Town region zone 1" do
    expect(RegionRepository.all.first.zone).to eq("1")
  end

  it "returns a Cape Town region zone 2" do
    expect(RegionRepository.all[1].zone).to eq("2")
  end

  it "calls PolygonRegion with the correct coordinates" do
    expect(RegionRepository).to receive(:file_data).and_return(json_stub)
    expect(RegionPolygon).to receive(:new).with([["0","0"],["10","0"],["10","10"],["0","10"]])
    expect(RegionRepository.all.size).to eq(1)
  end


  def json_stub
    '
    {
      "PlaceMarks":
      [
        {
          "Name": "2",
          "MultiGeometry": {
            "Polygons": [
              {
                "Extrude": "0",
                "AltitudeMode": "clampToGround",
                "OuterBoundaryIs": {
                  "LinearRing": {
                    "Coordinates": [
                      {
                        "Latitude": "0",
                        "Longitude": "0",
                        "Elevation": "0"
                      },
                      {
                        "Latitude": "10",
                        "Longitude": "0",
                        "Elevation": "0"
                      },
                      {
                        "Latitude": "10",
                        "Longitude": "10",
                        "Elevation": "0"
                      },
                      {
                        "Latitude": "0",
                        "Longitude": "10",
                        "Elevation": "0"
                      }
                    ]
                  }
                }
              }
            ]
          }
        }
      ]
    }
    '
  end

end
