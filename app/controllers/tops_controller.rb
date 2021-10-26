class TopsController < ApplicationController

    def index
        engine(root_path)
        # render plain: [session[:id], session[:subject]]
    end

end
