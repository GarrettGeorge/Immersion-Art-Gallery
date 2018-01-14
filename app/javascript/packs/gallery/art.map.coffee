import Room from './art.room.coffee'

W3 = "http://www.w3.org/2000/svg"
STROKE_COLOR_DEFAULT = "rgb(81, 81, 104)"
STROKE_WIDTH_DEFAULT = "5px"
EDGES = ["left", "top", "right", "bottom"]
EDGE_INDICES =
  left: 0
  top: 1
  right: 2
  bottom: 3

export default class Map
  constructor: (data) ->
    @rooms = Object.values(data).map (roomData) -> new Room(roomData)
    @map = @rooms.reduce (obj,room) ->
      obj["" + room.coordinate.x + ", " + room.coordinate.y] = room
      return obj
    , {}
    @HALLWAY_LENGTH =
    @drawRooms()

  drawRooms: ->
    t_map = @map
    @rooms.forEach (room, index) ->
      Map.createSVG {"room": room}
      for coord in room.nextRooms
        t_map[coord.x.toString() + ", " + coord.y.toString()].previousRoom = room

  @createSVG: (svgData) ->
    sColor = svgData.strokeColor ? STROKE_COLOR_DEFAULT
    sWidth = svgData.strokeWidth ? STROKE_WIDTH_DEFAULT
    room = svgData.room
    id = "room_#{room.coordinate.x},#{room.coordinate.y}"
    container = document.createElement "div"
    $(container).css
      "position": "absolute"
      "box-sizing", "border-box"
    if room.coordinate.x == 0 && room.coordinate.y == 0
      $(container).css
        "top": "50%"
        "left": "50%"
        "transform": "translate(-50%, -50%)"
    else
      $(container).css Map.getRoomPosition(room)
    svg = document.createElementNS W3, "svg"
    svg.setAttributeNS null, "id", id
    svg.setAttributeNS null, "height", room.height
    svg.setAttributeNS null, "width", room.width
    room_border = document.createElementNS W3, "path"
    room_border.setAttributeNS null, "d", Map.createPath(room, svg)
    room_border.setAttributeNS null, "stroke", sColor
    room_border.setAttributeNS null, "stroke-width", sWidth
    room_border.setAttributeNS null, "fill", "none"
    $ svg
      .append room_border
    $ container
      .append svg
    $ "#gallery__map"
      .append container
    room.cssOffset =
      "top": $(container).offset().top
      "left": $(container).offset().left
      "right": $(container).offset().left + $(container).outerWidth()

  @createPath: (room, svg) ->
    partialPaths = Map.partialEdgePath(room)
    fullPaths = Map.fullEdgePath(room)
    path = ""
    EDGES.forEach (e, i) ->
      if i == 0
        path += Map.getStartMove(room)
      path += (if room.edges.indexOf(e) < 0 then fullPaths[e] else partialPaths[e]) + " "
    console.log "path " + path
    path

  @getStartMove: (room) ->
    e = room.edges[0]
    if "left"
      "M0 #{room.height} "
    else if "top"
      "M0 0 "
    else if "right"
       "M#{room.width} 0 "
    else
      "M#{room.width} #{room.height} "

  @partialEdgePath: (room) ->
    hallway = 20
    left: "L 0 #{0.5 * room.height + hallway} M0 #{0.5 * room.height - hallway} L 0 0"
    top: "L #{0.5 * room.width - hallway} 0 M#{0.5 * room.width + hallway} 0 L #{room.width} 0"
    right: "L #{room.width} #{0.5 * room.height - hallway} M #{room.width} #{0.5 * room.height + hallway} L #{room.width} #{room.height}"
    bottom: "L #{0.5 * room.width + hallway} #{room.height} M #{0.5 * room.width - hallway} #{room.height} L 0 #{room.height}"

  @fullEdgePath: (room) ->
      left: "L 0 0"
      top: "L #{room.width} 0"
      right: "L #{room.width} #{room.height} "
      bottom: "L 0 #{room.height}"

  @getRoomPosition: (room) ->
    relativeParentDirection = room.relativeParentDirection()
    #HALLWAY_LENGTH = if room.numCollections >= 3 then 50 else 20
    HALLWAY_LENGTH = 100
    switch relativeParentDirection
      when "right"
        "top": room.previousRoom.cssOffset.top - 1 - (parseInt(room.height) - room.previousRoom.height)/2 + "px"
        "left": (room.previousRoom.cssOffset.left - HALLWAY_LENGTH - parseInt(room.width)) + "px"
      when "bottom"
        "top": (room.previousRoom.cssOffset.top - HALLWAY_LENGTH - parseInt(room.height)) + "px"
        "left": room.previousRoom.cssOffset.left - 1 - (parseInt(room.width) - room.previousRoom.width)/2 + "px"
      when "left"
        "top": room.previousRoom.cssOffset.top - (parseInt(room.height) - room.previousRoom.height)/2 + "px"
        "left": (room.previousRoom.cssOffset.right + HALLWAY_LENGTH) + "px"
      when "top"
        "top": (room.previousRoom.cssOffset.top - 1 + parseInt(room.previousRoom.height) + HALLWAY_LENGTH) + "px"
        "left": room.previousRoom.cssOffset.left - (parseInt(room.width) - room.previousRoom.width)/2 + "px"
