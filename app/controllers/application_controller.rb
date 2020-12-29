class ApplicationController < ActionController::Base

    def after_sign_out_path_for(resource)
        root_path
    end

    # ページに入れるユーザを制限する
  
    def limit_normal num
        if current_user.level < num then
            if current_user.level == 0 then
                redirect_to controller: :homes, action: :caution, params: {"level": num.to_s + "以上のユーザレベル"}
            else
                redirect_to controller: :edits, action: :caution, params: {"level": num.to_s + "以上のユーザレベル"}
            end
        end
    end

    def limit_strong
        if current_user.email != "nakanaka.tanaka4413@gmail.com" then
            if current_user.level == 0 then
                redirect_to controller: :homes, action: :caution, params: {"level": "最強のユーザレベル"}
            else
                redirect_to controller: :edits, action: :caution, params: {"level": "最強のユーザレベル"}
            end
        end
    end


    def get_table id, min, compere_title
        routes = Route.where(before_id: id,strength: min..).to_a

        score = []
        routes.each do |r|
            score.push(r.find_count)
        end

        if compere_title != nil then
            for i in 0..(routes.length-1) do
                for j in 0..(routes.length-2-i) do
                    if score[j][compere_title] < score[j+1][compere_title] then
                        s_keep = score[j]
                        score[j] = score[j+1]
                        score[j+1] = s_keep
                    end
                end
            end
        end

        for i in 0..(routes.length-1) do
            for j in 0..(routes.length-2-i) do
                if score[j]["strength"] < score[j+1]["strength"] then
                    s_keep = score[j]
                    score[j] = score[j+1]
                    score[j+1] = s_keep
                end
            end
        end

        group_score = score.group_by do |s|
            s["group"]
        end

        group_list = []
        routes.each do |r|
            if ! group_list.include?(r.group) then
                group_list.push(r.group)
            end
        end

        ret = []
        group_list.each do |g|
            ret.push(group_score[g])
        end
        ret.flatten!
        return ret
    end


end
