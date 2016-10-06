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
get '/api/characters' do
  name = params['name']
  role = params['role']

  if !name.nil? && !role.nil?
    characters = Character.where(name: name, role: role)
  elsif !name.nil?
    characters = Character.where(name: name)
  elsif !role.nil?
    characters = Character.where(role: role)
  else
    characters = Character.all.order(role: :ASC)
  end

  characters.to_json
end


# PUT /api/characters - update a character, read request body as JSON
put '/api/characters' do
  name = params['name']
  role = params['role']
  new_name = params['new_name']
  new_role = params['new_role']

  characters = Character.find_by(name: name, role: role)
  characters.update(name: new_name, role: new_role)
  characters.to_json
  status 201
end

# DELETE /api/characters - delete task, return success/failure status code
delete '/api/characters' do
  characters = Character.find_by(name: params['name'], role: params['role'])
  characters.destroy
end
