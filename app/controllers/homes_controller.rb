class HomesController < ApplicationController

    before_action :authenticate_user!, only: :caution
    layout "homes"
  
    def index
    end

    def show
      @title = params["title"]
      get_tables = Route.where(before_id: params["id"])
      if get_tables.blank? then
        redirect_to  controller: :homes, action: :constructing, params: {"title": @title , "id": params["id"]}
      end

      strength_max = 0
      get_tables.each do |g|
        if g.strength > strength_max then
          strength_max = g.strength
        end
      end

      @tables = []

      for i in 0..strength_max do

        j = strength_max - i
        add_table = get_tables.where(strength: j)

        add_table.each do |a|

          if a.strength >= 0 then
            @tables.push(a)
          end

          if a.group != 0 then
            same_group_table = get_tables.where(group: a.group)
            same_group_table.each do |s|
              if s.strength >= 0
                @tables.push(s)
                s.strength = -1
              end
            end
          end

        end
      end

    end

    def constructing
    end
  
    def caution
      @level = params["level"]
    end

end
