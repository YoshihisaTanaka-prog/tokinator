class HomesController < ApplicationController

    before_action :authenticate_user!, only: :caution
    layout "homes"
  
    def index
    end

    def show
      @title = params["title"]
      if params["id"].length > 1 then
        route = Route.where(after_id: params["id"]).last
        route.total_accessed += 1
        route.total_accessed_start = Time.now
        route.save
      end
      @tables = get_table params["id"],-1,"total_accessed"
      if @tables.blank? then
        redirect_to  controller: :homes, action: :constructing, params: {"title": params["title"] , "id": params["id"]}
      end
    end

    def constructing
    end
  
    def caution
      @level = params["level"]
    end

end
