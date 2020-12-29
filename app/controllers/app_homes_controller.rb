class AppHomesController < ApplicationController

    skip_before_action :verify_authenticity_token

    def show
      attribute = params["attribute"]
      if attribute.blank? then
        tables = get_table params["id"],0,"total-access"
      else
        tables = get_table params["id"],0,attribute+"-access"
      end
      render :json => tables
    end
    
end
