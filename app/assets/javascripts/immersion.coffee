# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  setup()

$ document
  .on "turbolinks:load", ->
    initLogout()
    return unless $("#mainContainer").length > 0
    ready()

initLogout = ->
  return unless $("#logout").length > 0
  $("#logout").on "click", ->
    $.ajax
      url: "/immersion/logout"
      type: "POST"
      format: "json"
      success: (data) ->
        if data.success
          window.location.href = "/immersion/login"
        else
          alert("Failed to log out. Try again.")
      failure: (error) ->
        alert("Failed to log out. Try again.")

setup = ->
  console.log("setting up")
  $ "#searchicon"
    .mouseenter ->
      $ this
      .children()
      .each ->
        this.setAttribute "stroke", "#CCCCCC"
    .mouseleave ->
      $ this
      .children()
      .each ->
        this.setAttribute "stroke", "white"

  $ "#divein"
    .click ->
      window.location.href = "/immersion/gallery"
