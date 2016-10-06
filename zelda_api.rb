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

# PUT /api/game - update & read request body as JSON
put '/api/game' do
  game = Game.find_by(name: params['name'])
  game.update(name: params['new_name'])
  status 201
  game.to_json
end

# DELETE /api/characters - delete & return success/failure status code
delete '/api/game' do
  game = Game.find_by(name: params['name'])
  game.destroy
end

# POST /api/hero - create a hero, read request body as JSON
post '/api/hero' do
  hero = Hero.create(name: params['name'])
  status 201
  hero.to_json
end

# PUT /api/hero - update & read request body as JSON
put '/api/hero' do
  hero = Hero.find_by(name: params['name'])
  hero.update(name: params['new_name'])
  status 201
  hero.to_json
end

# DELETE /api/hero - delete & return success/failure status code
delete '/api/hero' do
  hero = Hero.find_by(name: params['name'])
  hero.destroy
end

# POST /api/item - create a item, read request body as JSON
post '/api/item' do
  item = Item.create(name: params['name'])
  status 201
  item.to_json
end

# PUT /api/item - update & read request body as JSON
put '/api/' do
  item = Item.find_by(name: params['name'])
  item.update(name: params['new_name'])
  status 201
  item.to_json
end

# DELETE /api/characters - delete & return success/failure status code
delete '/api/' do
  item = Item.find_by(name: params['name'])
  item.destroy
end

# POST /api/hero-inventory - create hero inventory, read request body as JSON
post '/api/hero-inventory' do
  items = params['items'].to_s.split(',')

  inventory = []

  items.each do |item_id|
    inventory << HeroInventory.create(hero_id: params['hero_id'], game_id:
    params['game_id'], item_id: item_id)
  end
  status 201
  inventory.to_json
end

# PUT /api/characters - update & read request body as JSON
put '/api/' do
  variable = params['variable']
  new_variable = params['new_variable']
  new_role = params['new_role']

  thing = Class.find_by(name: variable)
  thing.update(name: new_variable)
  thing.to_json
  status 201
end

# DELETE /api/characters - delete & return success/failure status code
delete '/api/' do
  thing = Class.find_by(name: params['name'])
  thing.destroy
end

# GET /api/hero - return individual/all as JSON
get '/api/' do
  variable = params['variable']

  if !variable.nil?
    thing = Class.where(name: variable)
  else
    thing = Class.all.order(role: :DESC)
  end

  thing.to_json
end
