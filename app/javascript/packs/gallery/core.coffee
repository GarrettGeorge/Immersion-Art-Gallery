HALLWAY_WIDTH = 50
SMALLROOM_SIDE_LENGTH = 100

import GalleryMap from "./art.map.coffee"

ready = ->
  loadMap()
  setupSearch()
  setupMap()

$ document
  .on "turbolinks:load", ->
    ready() if $("#gallery__map-frame").length > 0

setupSearch = ->
  $ "#gray-searchicon"
    .mouseenter ->
      $ this
      .children()
      .each ->
        this.setAttribute "stroke", "#CCCCCC"
    .mouseleave ->
      $ this
      .children()
      .each ->
        this.setAttribute "stroke", "rgb(89,89,104)"

newTop = 0
newLeft = 0
ticking = false
setupMap = ->
  $("#gallery__map").css "top", -1 * $("#gallery__map-frame").offset().top
  .css "left", -1 * $("#gallery__map-frame").offset().left
  $("#gallery__map-frame").mousedown (down) ->
    startX = down.clientX
    startY = down.clientY
    startTop = parseInt $("#gallery__map").css("top").slice(0, -2)
    startLeft = parseInt $("#gallery__map").css("left").slice(0, -2)
    handleMouseMove = (move) ->
      move.preventDefault()
      newTop = startTop + move.clientY - startY
      newLeft = startLeft + move.clientX - startX
      requestTick(updateMap)
    $(document).mousemove handleMouseMove
    $(document).mouseup ->
      $(document).off "mousemove", handleMouseMove
  $("#gallery__map-frame")[0].addEventListener "mousewheel", handleMapScroll


handleMapScroll = (event) ->
  event.preventDefault()
  if event.deltaY > 0
    requestTick(zoomOut)
  else if event.deltaY < 0
    requestTick(zoomIn)

loadMap = ->
  $.ajax
    url: "./gallery/1/map"
    type: "GET"
    dataType: "json"
    success: (data) ->
      console.log data
      galleryMap = new GalleryMap(data)
    failure: (error) ->
      console.log "request failed"

updateMap = ->
  ticking = false
  $("#gallery__map").css
    "top": "#{newTop}px"
    "left": "#{newLeft}px"

zoomOut = ->
  ticking = false
  s = $("#gallery__map").css("transform")
  s = "scale(1.0)" if s == "none"
  scale = parseFloat(s.substring(s.indexOf("(") + 1, s.length - 1)) - .02
  return if scale <= .30
  $("#gallery__map").css("transform", "scale(#{scale})")

zoomIn = ->
  ticking = false
  s = $("#gallery__map").css("transform")
  s = "scale(1.0)" if s == "none"
  scale = parseFloat(s.substring(s.indexOf("(") + 1, s.length - 1)) + .02
  return if scale >= 3
  $("#gallery__map").css("transform", "scale(#{scale})")

# Utility functions
requestTick = (func) ->
  if !ticking
    requestAnimationFrame(func)
  ticking = true
