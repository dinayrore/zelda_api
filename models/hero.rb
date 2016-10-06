require 'active_record'
#
class Hero < ActiveRecord::Base
  self.table_name = 'heroes'
  validates :name, presence: true
end
