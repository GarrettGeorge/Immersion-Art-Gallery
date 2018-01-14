# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  setup()
  loadArtistData()

$ document
  .on "turbolinks:load", ->
    return unless $("#artists__container").length > 0
    ready()

setup = ->
  $(".element").each (index, ele) ->
    $(ele).css "height", $(ele).outerWidth() * 0.75
  $("#column-1 .element:first-child").on "click", ->
    window.location.href = "/immersion/artists/jackson-pollock"


loadArtistData = ->
  data = [
    {
      "first": "George"
      "last": "Henry"
      "url": "e534cb0c-bc45-11e7-abc4-cec278b6b50a"
    },
    {
      "first": "Joseph"
      "last": "Kosuth"
      "url": "0647f6dd-b525-4f0d-8106-f0a70d0ad03c"
    },
    {
      "first": "Jackson"
      "last": "Pollock"
      "url": "3a5a2eab-a47b-4370-a1af-289be96e1636"
    },
    {
      "first": "Salvador"
      "last": "Dali"
      "url": "043d8ee9-fda8-43d2-82e1-0a15f05cf61f"
    }
  ]
  middle = Math.floor data.length/2
  data.slice(0, middle).forEach (element, index) ->
    $("#column-0 .element:nth-child(#{index+1})").find("img")
    .prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" + element.url + ".jpg"
    $("#column-0 .element:nth-child(#{index+1}) > .name")
    .text(element.first + " " + element.last)
    $("#column-0 .element:nth-child(#{index+1})").on "click", ->
      window.location.href = "/immersion/artists/" + [element.first, element.last].join "-"
  data.slice(middle, data.length).forEach (element, index) ->
    $("#column-1 .element:nth-child(#{index+1})").find("img")
    .prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" + element.url + ".jpg"
    $("#column-1 .element:nth-child(#{index+1}) > .name")
    .text(element.first + " " + element.last)
    $("#column-1 .element:nth-child(#{index+1})").on "click", ->
      window.location.href = "/immersion/artists/" + [element.first, element.last].join "-"
