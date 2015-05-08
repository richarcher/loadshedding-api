require('geokit')

class RegionSelector
  def initialize(regions)
    @regions = regions
  end

  def my_region(lat, long)
    if @regions.any?
      @regions.each do |region|
        return region if region.contains?(lat, long)
      end
    end

    NullRegion.new
  end
end