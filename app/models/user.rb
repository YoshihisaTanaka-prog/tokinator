class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # def limit_normal(level)
  #   if self.level < level then
  #     return false
  #   else
  #     return true
  #   end
  # end

  # def limit_strong
  #   if self.email == 'nakanaka.tanaka4413@gmail.com'
  #     return true
  #   else
  #     return false
  #   end
  # end


  # def find_count(id)
  #     title_list = self.count_title_list
  #     ret = {}
      
  #     title_list.each do |t|
  #         counts = UCount.where(route_id: id, title: t).order(created_at)
  #         if counts.blank? or counts.last.created_at < self.latest_date then
  #             if  then
  #             c = UCount.new
  #             c.user_id = id
  #             c.title = t
  #             counts.push(c)
  #             end
  #         end
  #         ret[t] = counts
  #     end

  #     return ret
  # end


  # def count_plus(id,title)
  #     count = self.find_count(id)[title].last
  #     count.count += 1
  #     count.save
  # end

end
