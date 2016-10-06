require 'active_record'
require_relative 'hero'
require_relative 'item'
require_relative 'game'
#
class HeroInventory < ActiveRecord::Base
  self.table_name = 'hero_inventory'
  belongs_to :hero
  belongs_to :game
  belongs_to :item
end
