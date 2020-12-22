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


end
