class Room
  @num_collections = 0
  @edges = Array.new
  @coordinate = HashWithIndifferentAccess.new
  def initialize(coordinate)
    @coordinate = coordinate
    @next_rooms = Array.new
    p = rand(1...101)
    if p <= 35
      @num_collections = 1
    elsif p <= 70
      @num_collections = 2
    elsif p <= 85
      @num_collections = 3
    else
      @num_collections = 4
    end
  end

  def to_s
    @num_collections.to_s
  end

  def num_collections
    @num_collections
  end

  def addEdge(edge)
    if !@edges
      @edges = [edge]
    else
      @edges.push(edge)
    end
  end

  def coordinate=(coord)
    @coordinate = coord
  end

  def coordinate
    @coordinate
  end

  def previousRoom=(room)
    @previousRoom = room
  end

  def previousRoom
    @previousRoom
  end

  def update_next_rooms(coordinate)
    @next_rooms.push(coordinate)
  end

  def adj_coord(direction)
    temp_coord = @coordinate.dup
    case direction
    when "left" then temp_coord[:x] -= 1
    when "top" then temp_coord[:y] += 1
    when "right" then temp_coord[:x] += 1
    when "bottom" then temp_coord[:y] -= 1
    end
    temp_coord
  end

  def self.opposite_edge(direction)
    case direction
    when "left" then "right"
    when "top" then "bottom"
    when "right" then "left"
    when "bottom" then "top"
    end
  end
end
