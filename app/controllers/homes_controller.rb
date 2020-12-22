class HomesController < ApplicationController

    before_action :authenticate_user!, only: :caution
    layout "homes"
  
    def index
    end

    def show
      @title = params["title"]
      @tables = Route.where(before_id: params["id"])
      if @tables.blank? then
        redirect_to  controller: :homes, action: :constructing, params: {"title": @title , "id": params["id"]}
      end
    end

    def constructing
    end
  
    def caution
      @level = params["level"]
    end

end
