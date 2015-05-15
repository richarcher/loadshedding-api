require('./lib/region_polygon')

class Region
  attr_reader :name, :zone

  def initialize(name, zone, polygons)
    @name = name
    @zone = zone
    @polygons = polygons.map do |polygon_coords|
      RegionPolygon.new(polygon_coords)
    end
  end

  def contains?(latitude, longitude)
    @polygons.each do |polygon|
      return true if polygon.contains?(latitude, longitude)
    end
    false
  end
end

class NullRegion < Region
  def initialize
    super("", "", [])
  end

end
