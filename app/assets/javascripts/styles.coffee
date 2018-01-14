# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  setup()
  loadStyleData()

$(document).on "turbolinks:load", ->
  return unless $("#styles__container").length > 0
  ready()

setup = ->
  $(".element").each (index, ele) ->
    $(ele).css "height", $(ele).outerWidth() * 0.75

loadStyleData = ->
  data = [
    {
      "name": "Abstract Expressionism"
      "url": "4bc8f760-d728-44c9-a77b-68159a032bad"
    },
    {
      "name": "Cubism"
      "url": "7a162301-f999-4300-b67e-1bea2c458298"
    },
    {
      "name": "Minimalism"
      "url": "22b0ce3b-2a5d-4c8a-b32e-5f031a7e7baf"
    },
    {
      "name": "Expressionism"
      "url": "57e3e1ab-14ab-479a-bd17-4738f7936797"
    }
  ]
  middle = Math.floor data.length/2
  data.slice(0, middle).forEach (element, index) ->
    $("#column-0 .element:nth-child(#{index+1})").find("img")
    .prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" + element.url + ".jpg"
    $("#column-0 .element:nth-child(#{index+1}) > .name")
    .text element.name
    $("#column-0 .element:nth-child(#{index+1})").on "click", ->
      window.location.href = "/immersion/styles/" + element.name.replace(/ /g, "-").toLowerCase()
  data.slice(middle, data.length).forEach (element, index) ->
    $("#column-1 .element:nth-child(#{index+1})").find("img")
    .prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" + element.url + ".jpg"
    $("#column-1 .element:nth-child(#{index+1}) > .name")
    .text element.name
    $("#column-1 .element:nth-child(#{index+1})").on "click", ->
      window.location.href = "/immersion/styles/" + element.name
