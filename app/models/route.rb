class Route < ApplicationRecord
    
    mount_uploader :image, ImageUploader

    def count_title_list
        return []
    end

    def find_count(id)
        title_list = self.count_title_list
        ret = {}
        
        title_list.each do |t|
            counts = RCount.where(route_id: id, title: t).order(created_at)

            if counts.blank? or counts.last.created_at < self.latest_date then
                c = RCount.new
                c.route_id = id
                c.title = t
                counts.push(c)
            end

            ret[t] = counts
        end

        return ret
    end

    def count_plus(id,title)
        count = self.find_count(id)[title].last
        count.count += 1
        count.save
    end

end
