class AppHomesController < ApplicationController

    skip_before_action :verify_authenticity_token

    def index
      render ""
    end

    def show
      if request.post? then
        check_token params['token']
        attribute = params["attribute"]
        if attribute.blank? then
          tables = get_table params["id"],-1,"total_accessed"
        else
          tables = get_table params["id"],-1,attribute+"_accessed"
        end
        render :json => tables
      end
    end

    def chat
      if request.post? then
        check_token params['token']
        chats = SupportChat.where(customer_id: params['id']).order(:created_at)
        render :json => chats
      end
    end

    def chat_write
      if request.post? then
        check_token params['token']
        chat = SupportChat.new
        chat.customer_id = params['id']
        chat.text = params['text']
        chat.isFromCustomer = true
        chat.save
        render :json => chat
      end
    end
    
    def user
      if request.post? then
        check_token params['token']
        obj = Customer.new
        obj.user_attribute = params["attribute"]
        obj.save
        render :json => obj
      else
        obj = Customer.new
        obj.user_attribute = params["attribute"]
        obj.save
        render :json => obj
      end
    end

    def check_token token
      if token != 'hWpjDFW9USsSGMdwZTYZHHbLBX4xRXvj' then
        redirect_to app_path
      end  
    end
    
end
