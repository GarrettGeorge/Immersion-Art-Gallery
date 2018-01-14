import ArtCollection from './art.collection.coffee'

export default class Room
  constructor: (roomData) ->
    #@collections = roomData.collections.forEach (c, i) -> new ArtCollection(c)
    @numCollections = roomData["num_collections"]
    @coordinate = roomData.coordinate
    @edges = roomData.edges
    @height = switch @numCollections
      when 1 then "100"
      when 2 then "150"
      else  "175"
    @width = if @numCollections <= 2 then "100" else "175"
    @previousRoom = roomData.previousRoom
    @nextRooms = roomData["next_rooms"]

  relativeParentDirection: () ->
    if @coordinate.x < @previousRoom.coordinate.x
      "right"
    else if @coordinate.x > @previousRoom.coordinate.x
      "left"
    else if @coordinate.y > @previousRoom.coordinate.y
      "bottom"
    else
      "top"
