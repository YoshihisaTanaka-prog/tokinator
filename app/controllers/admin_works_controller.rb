class AdminWorksController < ApplicationController
    before_action :is_strongest_admin, :set_class_option

    def column
        ncmb_object = NCMB::DataStore.new "Column"
        @columns = ncmb_object.where('class_name', session[:class])
    end

    def update_column
        column_object = NCMB::DataStore.new "Column"
        if params[:objectId].blank?
            column = column_object.new
        else
            column = column_object.where(:objectId => params[:objectId]).first
        end
        column.acl = nil
        column.name = params[:name]
        column.class_name = session[:class]
        column.save
        redirect_to columns_path
    end

    def ncmb
        @columns = []
        @tables = []
        unless session[:class].blank?
            column_object = NCMB::DataStore.new "Column"
            columns = column_object.where("class_name", session[:class])
            columns.each do |column|
                @columns.push(column.name)
            end
            ncmb_object = NCMB::DataStore.new session[:class]
            @tables = ncmb_object.all
        end
    end

    def add_ncmb
        if !params["add_column"].blank? && params["class"] == 'Column'
            column_object = NCMB::DataStore.new "Column"
            column = column_object.new
            column.acl = nil
            column.name = params["name"]
            column.class_name = session[:class]
            column.save
        elsif session[:class]
            column_object = NCMB::DataStore.new "Column"
            columns = column_object.where("class_name", session[:class])
            ncmb_object = NCMB::DataStore.new session[:class]
            if params[:objectId].blank?
                @data = ncmb_object.new
                set_data
                @data.save
            else
                @data = ncmb_object.where(:objectId, params[:objectId]).first
                set_data
                @data.update
            end
        end
        redirect_to ncmbs_path
    end

    def set_class
        session[:class] = params[:name]
        redirect_to request.referrer || root_url
    end

    def update_ncmb_class        
    end
    
    def set_class_option
        @class_option = [['クラスを選択', '#']]
        ncmb_object = NCMB::DataStore.new "Class"
        classes = ncmb_object.all
        classes.each do |c|
            @class_option.push([c.name, 'class/'+c.name])
        end
    end

    private
    def set_data
        @data.acl = nil
        columns.each do |column|
            unless params[column.name].blank?
                @data.set(column.name, params[column.name])
            end
        end
    end

end
