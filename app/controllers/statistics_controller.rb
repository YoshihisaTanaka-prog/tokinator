class StatisticsController < ApplicationController

  before_action :authenticate_user!
  layout "statistics"
  
  def index
    limit_normal 2

    @users = User.all

    @users_scores = []
    @users.each do |u|
        @users_scores.push(get_user_score_hash u.id)
    end
  end

end
