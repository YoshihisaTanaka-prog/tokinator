class HomesController < ApplicationController

    before_action :authenticate_user!, only: :caution
    layout "homes"
  
    def index
    end

    def show
      @title = params["title"]
      @tables = get_table params["id"],0,"total-access"
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
