require_relative 'environment'
require 'active_record'
#
class CreateGameTable < ActiveRecord::Migration[5.0]
  def up
    create_table :games do |i|
      i.string :name
    end
  end

  def down
    drop_table :games
  end
end
#
class CreateHeroesTable < ActiveRecord::Migration[5.0]
  def up
    create_table :heroes do |h|
      h.string :name
    end
  end

  def down
    drop_table :heroes
  end
end
#
class CreateItemsTable < ActiveRecord::Migration[5.0]
  def up
    create_table :items do |i|
      i.string :name
    end
  end

  def down
    drop_table :items
  end
end
#
class CreateHeroesInventoryTable < ActiveRecord::Migration[5.0]
  def up
    create_table :hero_inventory, id: false do |i|
      i.belongs_to :hero
      i.belongs_to :game
      i.belongs_to :item
    end

    add_foreign_key :hero_inventory, :heroes
    add_foreign_key :hero_inventory, :games
    add_foreign_key :hero_inventory, :items
  end

  def down
    drop_join_table :hero_inventory
  end
end

def main
  action = (ARGV[0] || :up).to_sym

  CreateGameTable.migrate(action)
  CreateHeroesTable.migrate(action)
  CreateItemsTable.migrate(action)
  CreateHeroesInventoryTable.migrate(action)
end

main if __FILE__ == $PROGRAM_NAME
