class AdviceController < ApplicationController

    #  CRUDのC
    def create
        if request.post? then
            advice.create(advice_params)
        end
        redirect_to edits_show_path(:id =>params["id"])
    end

    # CRUDのU
    def update
        obj = Advice.find(params["id"])
        obj.update(advice_params)
        redirect_to edits_show_path(:id =>params["id"])
    end

    # CRUDのD
    def delete
        obj = Advice.find(params["id"])
        obj.destroy
        redirect_to edits_show_path(:id =>params["id"])
    end

    private
    def advice_params
        params.require(:advice).permit(:route_id, :image)
    end

end