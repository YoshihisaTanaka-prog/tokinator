class AuthoController < ApplicationController

    before_action :authenticate_user!
    layout "autho"
  
    def index
        limit_normal 1
    end

    def caution
        chats = SupportChat.where("text LIKE?","#{current_user.email}%").order(:created_at)
        if chats.blank? then
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

    def ReqUsrLv
        obj = SupportChat.new
        obj.customer_id = 0
        obj.isFromCustomer = true
        obj.text = params['user'] + 'さんが' + params['level'] + 'を要求しました'
        obj.url = "/autho?user=" + params['user']
        obj.save
        if current_user.level == 0 then
            redirect_to controller: :homes, action: :caution, params: {"level": params['level']}
        else
            redirect_to controller: :edits, action: :caution, params: {"level": params['level']}
        end
    end


    # 簡易編集系
    def plus
        limit_normal 2

        @id = params["id"]
        @title = params["title"]
        @before_id = params["before_id"]
        obj = Route.find(@id)
        obj.strength = params["strength"]
        obj.group = params["group"]
        obj.save

        redirect_to controller: :autho, action: :show, params: {"id": @before_id}
    end

    # 入力編集系

    def comment
        obj = Route.find(params['id'])
        obj.comment = params['comment']
        obj.save
        redirect_to controller: :autho, action: :show, params: {"id": params['id']}
    end

    def edit
        limit_normal 2
        @id = params["id"]
        @route = Route.find(@id)
    end

    def edit_update
        limit_normal 2
        if request.post? then
            if params['strength'].to_i < -2
                strength = -2
            else
                strength = params['strength'].to_i
            end

            if params['group'].to_i < 0
                group = 0
            else
                group = params['group'].to_i
            end

            @id = params["id"]
            @title = params["title"]
            @before_id = params["before_id"]
            obj = Route.find(@id)
            obj.table_name = params["table_name"]
            obj.next_title_name = params["next_title_name"]
            obj.strength = strength
            obj.group = group
            obj.comment = params["comment"]
            obj.save
            redirect_to controller: :autho, action: :show, params: {"id": obj.id}
        end
    end

    def title
        obj = Route.find(params['id'])
        obj.next_title_name = params['title']
        obj.save
        redirect_to edits_show_path(:id => params['id'])
    end

    def image
        uploader = ImageUploader.new
        uploader.store!(params['image'])
        obj = Route.find(params['id'])
        obj.image = params[:image]
        obj.save
        redirect_to edits_show_path(:id => params['id'])
    end


    # 追加系

    def edit_add
        limit_normal 2
        @route = Route.new
    end

    def edit_create
        limit_normal 2
        if request.post? then

            # 次のIDを取得
            next_id = params["before_id"] + "-" + (params["ids"].to_i + 1).to_s
            if params['strength'].to_i < -2
                strength = -2
            else
                strength = params['strength'].to_i
            end

            if params['group'].to_i < 0
                group = 0
            else
                group = params['group'].to_i
            end

            obj = Route.new({ before_id: params["before_id"], table_name: params["table_name"], next_title_name: params["next_title_name"], after_id: next_id, strength: strength, group: group, comment: params["comment"] })
            obj.save
            redirect_to controller: :autho, action: :show, params: {"id": obj.id}
        end
    end

    # 表示系

    def show
        limit_normal 2
        @obj = Route.find(params['id'])
        if @obj.before_id == 'index'
            @before_id = 0
        else
            @before_id = Route.where(after_id: @obj.before_id).last.id
        end
        @title = @obj.next_title_name
        @image_url = @obj.image.url
        @image = @obj.image
        @tables = get_table @obj.after_id,-2,nil

        @comment = @obj.comment
        @id = @obj.id
        @b_id = @obj.after_id
        @id_max = 0
        @group_max = -1
        @tables.each do |t|
            id =  t["after_id"].split("-").last.to_i
            if @id_max < id then
                @id_max = id
            end
            if @group_max < t.group then
                @group_max = t.group
            end
        end
        @group_max += 1
    end

    def search
        id = params["id"]
        if id == "0" then
            redirect_to controller: :autho, action: :show, params: {"title": "どのジャンルの問題ですか？" , "id": "0"}
        elsif id == "1" then
            redirect_to controller: :autho, action: :show, params: {"title": "どのジャンルの計算ですか？" , "id": "1"}
        else
            route = Route.where(after_id: id)
            if route.blank? then
                redirect_to edits_path
            else
                redirect_to controller: :autho, action: :show, params: {"title": route.last.next_title_name , "id": id}
            end
        end
    end


    # pdf系

    def upload_pdf
        if request.post? then
            @pdf = Pdf.new(upload_params)
            if @pdf.save
                redirect_to solution_path
            end
        end
    end

    def solution
    end


    # 権限を変更する

    def authentication_update
        limit_strong

        # データ更新のためのフォーム送信はPOSTではなくPATCHであることに注意
        obj = User.find(params[:user_id])
        obj.level = params[:level]
        obj.save
        
        redirect_to autho_path( :user => params['user'] )
    end
  
    def authentication
        limit_strong
        @msg = "Please type search word..."
        @users = User.where( "email LIKE?", "%#{params['user']}%" ).order( :id )
    end


    # DM

    def support
        limit_normal 1
        
        tables = SupportChat.all.order(created_at: :desc)
        @tables = tables.group_by do |t|
            t.customer_id
        end
    end

    def chat
        limit_normal 1

        id = params['id'].to_i
        @chats = SupportChat.where(customer_id: id).order(:created_at)
    end

    def chat_write
        limit_normal 1
        
        if request.post? then
            chat = SupportChat.new({customer_id: params['id'], text: params['text'], isFromCustomer: false})
            chat.save
            redirect_to support_chat_path( :id => params['id'])
        end
    end

    # private
    #     def route_params
    #         params.require(:route).permit(:image)
    #     end

end
