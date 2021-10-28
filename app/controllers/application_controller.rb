class ApplicationController < ActionController::Base
    before_action :common_first_method
    
    require 'rack'
    require 'ncmb'
    NCMB.initialize(
        application_key: ENV['NCMB_APP_KEY'],
        client_key: ENV['NCMB_CLIENT_KEY']
    )


    def common_first_method
        @setting_options = [['サイトの設定', '#'], ["権限管理", admin_all_path], ["データの追加・編集", ncmbs_path], ["カラムの追加", columns_path]]
    end

    def engine(sent_url)
        if sent_url.chars.last == '/'
            main_url = sent_url.chop
        else
            main_url = sent_url
        end

        url = Rails.application.routes.recognize_path(request.referrer)
        if url[:controller] == controller_name
            session[:id] = nil
        end

        unless params[:para].blank?
            if params[:para].include?("-")
                para = params[:para].split("-")
                if para[0] == 'sub'
                    ncmb_objects = NCMB::DataStore.new "Subject"
                    subjects = ncmb_objects.where('id', para[1])
                    unless subjects.blank?
                        subj = subjects.first
                        session[:subject] = subj.id
                        session[:subject_name] = subj.name
                    end
                else
                    session[:subject] = nil
                    session[:subject_name] = nil
                    session[:id] = nil
                    redirect_to root_path
                end
            else
                session[:id] = params[:para]
            end
        end

        @options = []
        @is_initial_page = false
        if session[:subject].blank?
            @is_initial_page = true
            ncmb_objects = NCMB::DataStore.new "Subject"
            subjects = ncmb_objects.all
            @question = "教科を選んでください。"
            subjects.each do |subject|
                @options.push({'name' => subject.name, 'url' => main_url+"/"+"sub-"+subject.id})
            end
        elsif session[:id].blank?
            object1 = NCMB::DataStore.new "Selection"
            new_options = object1.where("beforeId", 'sub-'+session[:subject])
            @question = "何を求めよと聞かれていますか？"
            new_options.each do |option|
                @options.push({'name' => option.myOption, 'url' => main_url+"/"+option.objectId})
            end
        else
            object1 = NCMB::DataStore.new "Selection"
            object2 = NCMB::DataStore.new "Selection"
            new_options = object1.where("beforeId", session[:id])
            selected_option = object2.where("objectId", session[:id]).first
            @question = selected_option[:nextQuestion]
            new_options.each do |option|
                @options.push({'name' => option.myOption, 'url' => main_url+"/"+option.objectId})
            end
        end
    end

    def is_permitted
        if admin_signed_in?
            if !current_admin.permitted
                redirect_to request.referrer || root_url
            end
        else
            redirect_to request.referrer || root_url
        end
    end

    def is_operator
        if admin_signed_in?
            if !current_admin.operator
                redirect_to request.referrer || root_url
            end
        else
            redirect_to request.referrer || root_url
        end
    end

    # 最高管理者以外はじくためのメソッド
    def is_strongest_admin
        if admin_signed_in?
            if !current_admin.admin
                redirect_to request.referrer || root_url
            end
        else
            redirect_to request.referrer || root_url
        end
    end

    # devise用のカラムを追加するために必要
    before_action :configure_permitted_parameters, if: :devise_controller?
    def configure_permitted_parameters
        # サインインする時に「name」カラムをいじることを許可
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        # ユーザー情報を編集する時に「name」カラムをいじることを許可
        devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

end
