require('json')
require('lib/region')


class RegionRepository
  def self.all
    file = file_data
    json = JSON.parse( file )['PlaceMarks']
    json.map do |placemark|
      Region.new("Cape Town", placemark['Name'], extract_polygons(placemark['MultiGeometry']['Polygons']) )
    end
  end

  def self.extract_polygons(polygons)
    polygons.map do |polygon|
      extract_coords(polygon["OuterBoundaryIs"]["LinearRing"]["Coordinates"])
    end
  end

  def self.extract_coords(coords)
    coords.map do |coord|
      [coord["Latitude"], coord["Longitude"]]
    end
  end

  def self.file_data
    File.read('./lib/zones.js')
  end

end
