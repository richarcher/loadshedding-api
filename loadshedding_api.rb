require 'grape'

module Loadshedding
  class API < Grape::API
    format :json

    resource :zone do
      desc "My Zone!"
      params do
        requires :lat, type: Float, desc: "Latitude"
        requires :long, type: Float, desc: "Longitude"
      end
      get do
        regions = RepositoryRepository.all
        selector = RegionSelector.new(regions)
        region = selector.my_region(params[:lat], params[:long])
        region.zone
      end
    end


  end
end
