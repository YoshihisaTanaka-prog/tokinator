class Customer < ApplicationRecord

    def count_title_list
        return ['open','total_access','total_score']
    end
  
    def latest_date
        return　Time.current.beginning_of_month
    end
  
    def find_count
      title_list = self.count_title_list
      #ret = {"id" => self.id, "before_id" => self.before_id, "table_name" => self.table_name, "next_title_name" => self.next_title_name, "after_id" => self.after_id, "group" => self.group, "strength" => self.strength}
      
      title_list.each do |t|
        counts = CCount.where(route_id: self.id, title: t).order(:created_at)
  
        if counts.present? or counts.blank? then
          c = CCount.new
          c.route_id = self.id
          c.title = t
          c.save
          ret[t] = c.count
          ret[t+"-array"] = [c.count]
        else
          if  self.latest_date > counts.last.created_at then
            c = CCount.new
            c.route_id = self.id
            c.title = t
            c.save
            counts = CCount.where(route_id: self.id, title: t).order(:created_at)
          end
          ret[t] = counts.last.count
          ret[t+"-array"] = []
          counts.each do|d|
            ret[t+"-array"].push(d.count)
          end
        end
      end
  
      return ret
    end

end
