class AdminWorksController < ApplicationController
    before_action :is_strongest_admin

    def tokinator_column
        @tokinator_column = TokinatorColumn.new
        @tokinator_columns = TokinatorColumn.all
    end

    def add_tokinator_column
        TokinatorColumn.create(tokinator_pramas)
        redirect_to tokinator_columns_path
    end

    def subject
        @subject = Subject.new
        @subjects = Subject.all
    end

    def add_subject
        Subject.create(subject_params)
        redirect_to subjects_path
    end

    private
    def subject_params
        params.require(:subject).permit(:name, :identifier)
    end
    def tokinator_pramas
        params.require(:tokinator_column).permit(:colunm_name)
    end

end
