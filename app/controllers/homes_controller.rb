class HomesController < ApplicationController

    before_action :authenticate_user!, only: [:caution, :nonreq]
    layout "homes"
  
    def index
    end

    def show
      obj = Route.find(params['id'])
      obj.total_accessed += 1
      @title = obj.next_title_name
      @comment = obj.comment
      @tables = get_table obj.after_id,-1,'total_accessed'
      if @tables.blank? then
        obj.constructing += 1
        redirect_to  controller: :homes, action: :constructing, params: {"title": @title , "id": obj.after_id}
      end
      obj.save
    end

    def constructing
    end
  
    def caution
      chats = SupportChat.where("text LIKE?","#{current_user.email}%").order(:created_at)
      if chats.blank? then
        @time1 = Time.current
        @time2 = Time.current
        @show = true
      else
        now = Time.current
        @time1 = chats.last.created_at
        @time2 = now.yesterday
        if chats.last.created_at < @time2 then
          @show = true
        else
          @show = false
        end
      end
      @hour = (@time1 - @time2).to_i / 3600
      @second = (@time1 - @time2).to_i / 60 - @hour * 60
      @minute = (@time1 - @time2).to_i % 60
      @level = params["level"]
    end

end
