class AdminsController < ApplicationController
    before_action :is_strongest_admin

    def show
        if params[:search].blank?
            @admins = Admin.all
        elsif params[:search] == "boolean-true"
            @admins = Admin.where(permitted: true)
        elsif params[:search] == "boolean-false"
            @admins = Admin.where(permitted: false)
        else
            @admins = Admin.where(name: params[:search])
        end
    end

    # ある管理者に編集権限を付与したり奪ったりするためのアクション
    def permission
        admin = Admin.find(params[:id])
        admin.permitted = !admin.permitted
        if admin.save
            redirect_to admin_all_path
        else
            redirect_to root_path
        end
    end

    def operator
        admin = Admin.find(params[:id])
        if admin.permitted
            admin.operator = !admin.operator
            if admin.save
                redirect_to admin_all_path
            else
                redirect_to root_path
            end
        else
            redirect_to admin_all_path
        end
    end

    # ある管理者を最高権限に変えて自分を普通の管理者にするためのアクション
    def admin
        if params[:id].to_i != current_admin.id
            admin = Admin.find(params[:id])
            if admin.permitted
                admin.permitted = true
                admin.operator = true
                admin.admin = true
                admin.save
                current_admin.admin = false
                admin.save
            end
        end
        redirect_to admin_all_path
    end

end
