class AppHomesController < ApplicationController

    skip_before_action :verify_authenticity_token

    def show
      attribute = params["attribute"]
      if attribute.blank? then
        tables = get_table params["id"],-1,"total_accessed"
      else
        tables = get_table params["id"],-1,attribute+"_accessed"
      end
      render :json => tables
    end

    def chat
      chats = SupportChat.where(customer_id: params['id']).order(:created_at)
      render :json => chats
    end

    def chat_write
      if request.post? then
        chat = SupportChat.new
        chat.customer_id = params['id']
        chat.text = params['text']
        chat.isFromCustomer = true
        chat.save
        render :json => chat
      end
    end
    
end
