# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  setup()
  loadExhibitData()

$ document
  .on "turbolinks:load", ->
    return unless $("#exhibits__container").length > 0
    ready()

setup = ->
  $(".element").each (index, ele) ->
    $(ele).css "height", $(ele).outerWidth() * 0.75
  # $("#column-0 .element:first-child").on "click", ->
  #   window.location.href = "/immersion/artists/jackson-pollock"


loadExhibitData = ->
  $.ajax
    url: encodeURI("/immersion/exhibits/data?all=true")
    type: "GET"
    dataType: "json"
    success: (data) ->
      console.log data
      middle = Math.ceil data.length/2
      data.slice(0, middle).forEach (ele, index) ->
        element = document.createElement "div"
        $(element).addClass "element"
        .on "click", ->
          window.location.href = "/immersion/exhibits/" + encodeURI(ele["Title"])
        image = document.createElement "div"
        $(image).addClass "image"
        img = document.createElement "img"
        $(img).prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" +
          ele["main_image"] + ".jpg"
        background = document.createElement "div"
        $(background).addClass "background"
        name = document.createElement "div"
        $(name).addClass "name"
        .text ele["Title"]

        image.appendChild img
        element.appendChild image
        element.appendChild background
        element.appendChild name

        document.querySelector("#column-0").appendChild element
      data.slice(middle, data.length).forEach (ele, index) ->
        element = document.createElement "div"
        $(element).addClass "element"
        .on "click", ->
          window.location.href = "/immersion/exhibits/" + encodeURI(ele["Title"])
        image = document.createElement "div"
        $(image).addClass "image"
        img = document.createElement "img"
        $(img).prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" +
          ele["main_image"] + ".jpg"
        background = document.createElement "div"
        $(background).addClass "background"
        name = document.createElement "div"
        $(name).addClass "name"
        .text ele["Title"]

        image.appendChild img
        element.appendChild image
        element.appendChild background
        element.appendChild name

        document.querySelector("#column-1").appendChild element

      $(".element").each (index, ele) ->
        $(ele).css "height", $(ele).outerWidth() * 0.75
    failure: (error) ->
      console.log "Error reading exhibit data"
