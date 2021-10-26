class TokinatorColumn < ApplicationRecord

    def all_colunm
        columns = TokinatorColumn.all
        ret = []
        columns.each do |column|
            ret << column.column_name
        end
        return ret
    end

end
