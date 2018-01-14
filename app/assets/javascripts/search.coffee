# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  setup()

$ document
  .on "turbolinks:load", ->
    return unless $("#searchpage__collectionContainer").length > 0
    ready()

searchImages = []
setup = ->
  $("#collection__panel-grid > form > input:last-child").on "click", ->
    form = $(this.parentElement)
    params = []
    title = form.find("#artwork_title").val()
    if title != "" then params.push {
      qs: "title"
      val: title
    }
    artist = form.find("#artist").val()
    if artist != "" then params.push {
      qs: "artist"
      val: artist
    }
    date = form.find("#date").val()
    if date != "" then params.push {
      qs: "date"
      val: date
    }
    style = form.find("#artwork_style").val()
    if style != "" then params.push {
      qs: "style"
      val: style
    }
    medium = form.find("#medium").val()
    if medium != "" then params.push {
      qs: "medium"
      val: medium
    }
    uuid = form.find("#uuid").val()
    if uuid != "" then params.push {
      qs: "uuid"
      val: uuid
    }
    urls = ""
    for p in params
      urls += "#{p.qs}=#{p.val}&"

    if params.length == 0
      urls = "all=true"

    $.ajax
      url: "/immersion/search/input?" + urls
      type: "GET"
      format: "json"
      success: (data) ->
        console.log data
        searchImages = data
        loadImages data
      failures: (error) ->
        console.log "Failed to read gallery data"

loadImages = (images) ->
  $("#collection__images div").each (index, ele) ->
    $(ele).html ""
  $("#collection__panel-grid > form > input:last-child").prop("disabled", false)
  for image, index in images
    (() ->
      container = document.createElement "div"
      $(container).addClass "image-container"
      .data("index", index)

      img = document.createElement "img"
      $(img).addClass "image"
      .prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" +
        image["UUID"] + ".jpg"

      imgOverlay = document.createElement "div"
      $(imgOverlay).addClass "image-overlay"
      overlayInfo = document.createElement "div"
      $(overlayInfo).addClass "info"
      overlayTitle = document.createElement "div"
      $(overlayTitle).text image["Title"] || ""
      .addClass "title"
      overlayArtist = document.createElement "div"
      $(overlayArtist).text image["Artist"] || ""
      .addClass "artist"
      overlayDate = document.createElement "div"
      $(overlayDate).text image["Year Produced"] || ""
      .addClass "date"
      $(overlayInfo).append overlayTitle
      .append overlayArtist
      .append overlayDate
      $(imgOverlay).append overlayInfo

      $(container).append img
      .append imgOverlay
      $("#collection__images #image-col-#{index%4}").append container

      $(container).mouseenter (element) ->
        $(imgOverlay).css "display", "block"
      .mouseleave ->
        $(imgOverlay).css "display", ""
    )()

  fullscreenImageSetup()

currentIndex = 0
fullscreenImageSetup = ->
  panelSingle = $("#collection__panel-single")
  $("#collection__images .image-container").on "click", ->
    $("#collection__panel-grid").css "display", "none"
    infoFrame = panelSingle.find("#info-frame")
    currentIndex = $(this).data("index")
    info = searchImages[currentIndex]
    infoFrame.find("#frame-title").text(info["Title"])
    infoFrame.find("#artist").text(info["Artist"])
    infoFrame.find("#date").text(info["Year Produced"])
    #infoFrame.find("#medium").text(info["Medium"])
    panelSingle.css "display", "block"
    panelSingle.find("#central-image").fadeIn 150
    $("#central-image-container").css "left", "calc(50% + #{infoFrame.outerWidth()/2 + 25}px)"
    panelSingle.find("#central-image")
      .prop "src", "#{$(this).find(".image").prop("src")}"

  panelSingle.find("#left-image").on "click", ->
    infoFrame = panelSingle.find("#info-frame")
    return if currentIndex == 0
    currentIndex -= 1
    info = searchImages[currentIndex]
    infoFrame.fadeOut 200
    panelSingle.find("#central-image").fadeOut 200, ->
      infoFrame.find("#frame-title").text(info["Title"])
      infoFrame.find("#artist").text(info["Artist"])
      infoFrame.find("#date").text(info["Year Produced"])
      #infoFrame.find("#medium").text(info["Medium"])
      $(this)
      .prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" +
        info["UUID"] + ".jpg"
      .fadeIn 150
      infoFrame.fadeIn 150
      $("#central-image-container").css "left", "calc(50% + #{infoFrame.outerWidth()/2 + 25}px)"

  panelSingle.find("#right-image").on "click", ->
    infoFrame = panelSingle.find("#info-frame")
    return if currentIndex == searchImages.length - 1
    currentIndex += 1
    info = searchImages[currentIndex]
    infoFrame.fadeOut 200
    panelSingle.find("#central-image").fadeOut 200, ->
      infoFrame.find("#frame-title").text(info["Title"])
      infoFrame.find("#artist").text(info["Artist"])
      infoFrame.find("#date").text(info["Year Produced"])
      #infoFrame.find("#medium").text(info["Medium"])
      $(this)
      .prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" +
        info["UUID"] + ".jpg"
      .fadeIn 150
      infoFrame.fadeIn 150
      $("#central-image-container").css "left", "calc(50% + #{infoFrame.outerWidth()/2 + 25}px)"

  $(document).keyup (e) ->
    switch e.which
      when 37
        infoFrame = panelSingle.find("#info-frame")
        return if currentIndex == 0
        currentIndex -= 1
        info = searchImages[currentIndex]
        infoFrame.fadeOut 200
        panelSingle.find("#central-image").fadeOut 200, ->
          infoFrame.find("#frame-title").text(info["Title"])
          infoFrame.find("#artist").text(info["Artist"])
          infoFrame.find("#date").text(info["Year Produced"])
          #infoFrame.find("#medium").text(info["Medium"])
          $(this)
            .prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" +
              info["UUID"] + ".jpg"
            .fadeIn 150
          infoFrame.fadeIn 150
          $("#central-image-container").css "left", "calc(50% + #{infoFrame.outerWidth()/2 + 25}px)"
      when 39
        infoFrame = panelSingle.find("#info-frame")
        return if currentIndex == searchImages.length - 1
        currentIndex += 1
        info = searchImages[currentIndex]
        infoFrame.fadeOut 200
        panelSingle.find("#central-image").fadeOut 200, ->
          infoFrame.find("#frame-title").text(info["Title"])
          infoFrame.find("#artist").text(info["Artist"])
          infoFrame.find("#date").text(info["Year Produced"])
          #infoFrame.find("#medium").text(info[])
          $("#central-image-container").css "left", "calc(50% + #{infoFrame.outerWidth()/2 + 25}px)"
          $(this)
          .prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" +
            info["UUID"] + ".jpg"
          .fadeIn 150
          infoFrame.fadeIn 150
          $("#central-image-container").css "left", "calc(50% + #{infoFrame.outerWidth()/2 + 25}px)"
      else return

  panelSingle.find("#gotoGrid").on "click", ->
    panelSingle.fadeOut 200, ->
      $("#collection__panel-grid").fadeIn 150, ->
        $("#collection__panel-single #central-image").css "display", "none"
