require 'openssl'
require 'geokit'

class RegionPolygon
  def initialize(coordinates)
    lat_longs = coordinates.map do |lt, lg|
      Geokit::LatLng.new(lt, lg)
    end
    @polygon = Geokit::Polygon.new(lat_longs)
  end

  def contains?(latitude, longitude)
    coord = Geokit::LatLng.new(latitude, longitude)
    @polygon.contains?(coord)
  end
end