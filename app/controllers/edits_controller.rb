class EditsController < ApplicationController

    def index
        engine(edits_path)
    end

    def update
        ncmb_object = NCMB::DataStore.new "Selection"
        if params[:objectId].blank?
            @data = ncmb_object.new
            set_data
            @data.save
        else
            @data = ncmb_object.where('objectId', params[:objectId]).first
            set_data
            @data.update
        end
        redirect_to edits_path
    end

    private
    def set_data
        ncmb_object = NCMB::DataStore.new 'Column'
        columns = ncmb_object.where('class_name', 'Selection')
        @data.acl = nil
        if session[:id].blank?
            @data.beforeId = 'sub-'+session[:subject]
        else
            @data.beforeId = session[:id]
        end
        columns.each do |column|
            unless params[column.name].blank?
                @data.set(column.name, params[column.name])
            end
        end
    end

end
