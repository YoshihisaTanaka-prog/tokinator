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
        if current_user.id != 1 then
            if current_user.level == 0 then
                redirect_to controller: :homes, action: :caution, params: {"level": "最強のユーザレベル"}
            else
                redirect_to controller: :edits, action: :caution, params: {"level": "最強のユーザレベル"}
            end
        end
    end


    def get_table id, min, compere_title
        if compere_title.blank? then
            routes = Route.where(before_id: id,strength: min..).order("strength DESC")
        else
            routes = Route.where(before_id: id,strength: min..).order("strength DESC",compere_title + " DESC")
        end

        group_routes = routes.group_by do |r|
            r.group
        end

        group_list = []
        routes.each do |r|
            if ! group_list.include?(r.group) then
                group_list.push(r.group)
            end
        end

        ret = []
        group_list.each do |g|
            ret.push(group_routes[g])
        end
        ret.flatten!
        return ret
    end


end
