class AuthoController < ApplicationController

    before_action :authenticate_user!
    layout "autho"
  
    def index
        limit_normal 1
    end

    def caution
        @level = params["level"]
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

        redirect_to controller: :autho, action: :show, params: {"title": @title , "id": @before_id}
    end

    # 入力編集系

    def edit
        limit_normal 2
        @id = params["id"]
        @route = Route.find(@id)
    end

    def edit_update
        limit_normal 2

        @id = params["id"]
        @title = params["title"]
        @before_id = params["before_id"]
        obj = Route.find(@id)
        obj.table_name = params["table_name"]
        obj.next_title_name = params["next_title_name"]
        obj.save

        redirect_to controller: :autho, action: :show, params: {"title": @title , "id": @before_id}
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

            obj = Route.new({ before_id: params["before_id"], table_name: params["table_name"], next_title_name: params["next_title_name"], after_id: next_id })
            obj.save
        end
        @title = params["title"]
        @before_id = params["before_id"]
        redirect_to controller: :autho, action: :show, params: {"title": @title , "id": @before_id}
    end

    # 表示系

    def show
        limit_normal 2
        @before_id = params["id"]
        if @before_id == "0"
            @before_title = ""
        elsif @before_id == "1"
            @before_title = ""
        else
            @bbefore_id = Route.where(after_id: @before_id).last.before_id
            if @bbefore_id == "0" then
                @before_title = "どのジャンルの問題ですか？"
            elsif @bbefore_id == "1" then
                @before_title = "どのジャンルの計算ですか？"
            else
                @before_title = Route.where(after_id: @bbefore_id).last.next_title_name
            end
        end
        @title = params["title"]
        @tables = get_table @before_id,-2,nil

        @ids = 0
        @tables.each do |t|
            id =  t["after_id"].split("-").last.to_i
            if @ids < id then
                @ids = id
            end
        end
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


    # 権限を変更する

    def authentication_update
        limit_strong

        # データ更新のためのフォーム送信はPOSTではなくPATCHであることに注意
        obj = User.find(params[:user_id])
        obj.level = params[:level]
        obj.save
        
        redirect_to "/autho"
    end
  
    def authentication
        limit_strong

        @msg = "Please type search word..."
    
        @q = User.ransack(params[:q])
        @users = @q.result(distinct: true)
    end

end
