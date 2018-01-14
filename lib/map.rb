require "active_support/core_ext/hash/indifferent_access"
require 'pp'
require 'json'
require 'room.rb'

class MapGenerator
  DIRECTIONS = ["left", "top", "right", "bottom"]

  def initialize(num_rooms)
    @map = HashWithIndifferentAccess.new
    @max_dim = num_rooms
    @edge_count = {
      left: 0,
      top: 0,
      right: 0,
      bottom: 0
    }.with_indifferent_access
    generate_map(num_rooms)
  end

  def map
    @map
  end

  def to_s
    # @max_dim.times do |j|
    #   for i in (-1 * @max_dim/2)..@max_dim/2
    #     if @map.key?("#{i},#{j}")
    #       puts "Num collections at #{i},#{j} " + @map["#{i},#{j}"].num_collections.to_s + "\t"
    #     end
    #   end
    # end
    puts JSON.pretty_generate(@map)
  end

  def generate_map(num_rooms)
    current_room = make_first_room()
    num_rooms.times do
      edges = evaluate_edges(current_room).dup
      next if edges.nil?
      new_rooms = []
      rand(1...edges.length + 1).times do |i|
        rand_edges_index = get_rand_edge(edges)
        new_room = Room.new(current_room.adj_coord(
          edges[rand_edges_index]
        ))
        new_room.addEdge(Room.opposite_edge(edges[rand_edges_index]))
        new_room.previousRoom = current_room
        @edge_count[edges[rand_edges_index]] += 1
        new_rooms.push(new_room)
        @map["#{new_room.coordinate[:x]},#{new_room.coordinate[:y]}"] = new_room
        current_room.addEdge(edges[rand_edges_index])
        current_room.update_next_rooms(new_room.coordinate)
        edges -= [edges[rand_edges_index]]
      end
      current_room = new_rooms[0]
    end
  end

  def evaluate_edges(room)
    DIRECTIONS.dup.collect do |d|
      next if room.adj_coord(d)[:y] < 0 ||
        @map.key?("#{room.adj_coord(d)[:x]},#{room.adj_coord(d)[:y]}")
      d
    end.compact!
  end

  def get_rand_edge(edges)
    p = {
      left: 15,
      right: 15,
      top: 60,
      bottom: 10
    }.with_indifferent_access
    local_p = []
    if(edges.include?("left") || edges.include?("right"))
      ratio = lr_ratio()
      p["left"] = ratio *  50 / (ratio + 1)
      p["right"] = 50 / (ratio + 1)
    end
    total = 0
    edges.each do |e|
      total += p[e]
      local_p += [total, e]
    end
    prob = rand(0..total)
    rand_index = -1
    edges.length.times do |i|
      if prob <= local_p[2*i]
        rand_index = i
        break
      end
    end
    rand_index
  end

  def lr_ratio
    if @edge_count["right"] == 0 || @edge_count["left"] == 0
      1
    else
      @edge_count["right"]/@edge_count["left"]
    end
  end

  def make_first_room
    @map["0,0"] = Room.new({
      x: 0,
      y: 0
    })
  end
end
