require 'sinatra'
require 'active_record'
require_relative 'environment'
require_relative 'models/game'
require_relative 'models/hero'
require_relative 'models/item'
require_relative 'models/hero_inventory'

# POST /api/game - create a game, read request body as JSON
post '/api/game' do
  game = Game.create(name: params['name'])
  status 201
  game.to_json
end

# POST /api/hero - create a hero, read request body as JSON
post '/api/hero' do
  hero = Hero.create(name: params['name'])
  status 201
  hero.to_json
end

# POST /api/item - create a item, read request body as JSON
post '/api/item' do
  item = Item.create(name: params['name'])
  status 201
  item.to_json
end

# POST /api/hero-inventory - create hero inventory, read request body as JSON
post '/api/hero/:name/inventory' do |hero|
  hero = params['hero']
  games = params['games'].to_s.split(',')
  items = params['items'].to_s.split(',')

  inventory = []

  games.each do |game_id|
	items.each do |item_id|
	  inventory << HeroInventory.create(hero_id: hero, game_id: game_id, item_id: item_id)
	end
  end

  status 201
  inventory.to_json
end

# GET /api/hero - return individual/all characters as JSON
get '/api/' do
  variable = params['variable']

  if !variable.nil?
    thing = Class.where(name: variable)
  else
    thing = Class.all.order(role: :DESC)
  end

  thing.to_json
end


# PUT /api/characters - update a character, read request body as JSON
put '/api/' do
  variable = params['variable']
  new_variable = params['new_variable']
  new_role = params['new_role']

  thing = Class.find_by(name: variable)
  thing.update(name: new_variable)
  thing.to_json
  status 201
end

# DELETE /api/characters - delete task, return success/failure status code
delete '/api/' do
  thing = Class.find_by(name: params['name'])
  thing.destroy
end
