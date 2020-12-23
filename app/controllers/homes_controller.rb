class HomesController < ApplicationController

    before_action :authenticate_user!, only: :caution
    layout "homes"
  
    def index
    end

    def show
      @title = params["title"]
      @tables = Route.where(before_id: params["id"], strength: 0..)
      get_routes = Route.where(before_id: params["id"])
      if get_routes.blank? then
        redirect_to  controller: :homes, action: :constructing, params: {"title": @title , "id": params["id"]}
      end

      # strength_max = 0
      # get_tables = []
      # get_routes.each do |g|

      #   if g.strength > strength_max then
      #     strength_max = g.strength
      #   end

      #   get_table = {}
      #   get_table["id"] = g.id
      #   get_table["before_id"] = g.before_id
      # t.string        :next_title_name
      # t.string        :table_name
      # t.string        :after_id
      # t.integer       :strength , null: false, default: 0
      # t.integer       :group 

      #   get_tables.push(get_table)
      # end

      # @tables = []

      # for i in 0..strength_max do

      #   add_table = get_tables.where( strength: strength_max - i )

      #   add_table.each do |a|

      #     if a.strength >= 0 then
      #       @tables.push(a)
      #       get_tables.find_by(id: a.id).strength = -1
      #     end

      #     if a.group != 0 then
      #       same_group_table = get_tables.where( group: a.group )
      #       same_group_table.each do |s|
      #         if s.strength >= 0
      #           @tables.push(s)
      #           get_tables.find_by(id: s.id).strength = -1
      #         end
      #       end
      #     end

      #   end
      # end

    end

    def constructing
    end
  
    def caution
      @level = params["level"]
    end

end
