class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def latest_date
    return Time.current.all_month
  end

end
