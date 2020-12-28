class AppHomesController < ApplicationController

    skip_before_action :verify_authenticity_token

    def show
      title = params["title"]
      tables = Route.where(before_id: params["id"], strength: 0..)
      # get_routes = Route.where(before_id: params["id"])

      # if tables.blank? then
      #   render :json => []
      # end

      render :json => tables
    end
end
