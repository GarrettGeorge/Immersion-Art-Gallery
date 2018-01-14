ready = ->
  setup()
  getExhibitData()

$ document
  .on "turbolinks:load", ->
    return unless $("#exhibitpage__initContainer").length > 0
    ready()

setup = ->
  $("#gray-nav-bar #title").css "color", "white"
  $("#gray-nav-bar > #logo").css "background", "url(/assets/ImmersionLogo.svg)"
  $("#collection .image").css "display", "block"
  description = $ "#description"
  .addClass "description-hover"

  $("#exhibitpage__initContainer #description").mouseenter (event) ->
    $(".gallery__nav-links").css "color", ""
    $("#gray-searchicon").children().each (index, ele) ->
      ele.setAttribute "stroke", "rgb(89,89,104)"
    $("#description .image").css "display", "none"
    $("#collection").removeClass "collection-hover"

    $("#gray-nav-bar #title").css "color", "white"
    $("#gray-nav-bar > #logo").css "background", "url(/assets/ImmersionLogo.svg)"
    $("#collection .image").css "display", "block"
    description.addClass("description-hover")

  $("#description").mouseleave (event) ->
    return if event.clientX < Math.floor $("#description").outerWidth()
    description.removeClass "description-hover"
    $("#gray-nav-bar #title").css "color", ""
    $("#gray-nav-bar > #logo").css "background", "url(/assets/ImmersionLogoGray.svg)"
    $("#collection .image").css "display", "none"
  .on "click", (event) ->
    return if event.target.tagName == "A"
    $("#exhibitpage__descriptionContainer").css "display", "block"
    $("#gray-nav-bar #title").css "color", ""
    $("#gray-nav-bar > #logo").css "background", "url(/assets/ImmersionLogoGray.svg)"
    $(this).css "left", "-50%"
    $("#exhibitpage__initContainer #collection").css "left", "100%"
    $(this).one "webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend", ->
      return if this.style.left == "0%"
      $("#exhibitpage__initContainer").css "z-index", "1"

  $("#exhibitpage__initContainer #collection").mouseenter (event) ->
    $("#description .title").removeClass "initial-title"
    description.removeClass "description-hover"
    $("#gray-nav-bar #title").css "color", ""
    $("#gray-nav-bar > #logo").css "background", "url(/assets/ImmersionLogoGray.svg)"
    $("#collection .image").css "display", "none"

    $(".gallery__nav-links").css "color", "white"
    $("#gray-searchicon").children().each (index, ele) ->
      ele.setAttribute "stroke", "white"
    $("#description .image").css "display", "block"
    $("#collection").addClass "collection-hover"

  $("#collection").mouseleave (event) ->
    return if event.clientX > $("#description").outerWidth()
    $(".gallery__nav-links").css "color", ""
    $("#gray-searchicon").children().each (index, ele) ->
      ele.setAttribute "stroke", "rgb(89,89,104)"
    $("#description .image").css "display", "none"
    $("#collection").removeClass "collection-hover"
  .on "click", (event) ->
    return if event.target.tagName == "A"
    $("#exhibitpage__collectionContainer").css "display", "block"
    $(this).css "left", "100%"
    $(".gallery__nav-links").css "color", ""
    $("#gray-searchicon").children().each (index, ele) ->
      ele.setAttribute "stroke", "rgb(89,89,104)"
    $("#collection__panel-grid").css "display", "block"
    $("#exhibitpage__initContainer #description").css "left", "-50%"
    $(this).one "webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend", ->
      return if this.style.left == "50%"
      $("#exhibitpage__initContainer").css "z-index", "1"
      $("#collection__panel-cover-flow").css "transform", "translate(-100%, -50%)"

  $(".nav-back").on "click", ->
    $("#exhibitpage__descriptionContainer, #exhibitpage__collectionContainer")
      .fadeOut(300)
    $("#exhibitpage__initContainer").css "z-index", "2"
    $("#exhibitpage__initContainer #description").css "left", "0%"
    $("#exhibitpage__initContainer #collection").css "left", "50%"
    $("#collection__panel-cover-flow").css "transform", "translate(100%, -50%)"
    $("#collection__panel-grid").css "display", ""

title = ""
subtitle = ""
getExhibitData = ->
  href = window.location.href.replace(/%20/ig, " ")
  exhibitName = href.substring(href.lastIndexOf("/")+1).split ": "
  title = exhibitName[0]
  subtitle = exhibitName[1]
  $("#description-content-title").text title + ": " + subtitle
  $("#description .name").text title
  $("#collection .name").text subtitle
  $.ajax
    url: encodeURI("./data?exhibitName=#{exhibitName.join(": ")}")
    type: "GET"
    format: "json"
    success: (data) ->
      console.log data
      loadExhibitData data
    failure: (error) ->
      console.log "Error reading exhibit data for exhibit: " + exhibitName.join(": ")

loadExhibitData = (data) ->
  description = data
  $("#description .image")
  .css "background-image", "url('https://s3.amazonaws.com/immersiongallery/gallery/" +
    description["main_image"] + ".jpg')"
  if description["description"]
    $("#description-text").html(description["description"].replace(/\n/ig, "<br>"))
  textContainer = $ "#description .text-container"
  textContainer.find("#date").text(description["start_date"])
  textContainer.find("#location").text(description["end_date"])

  mainImage = data.mainImage
  textContainer = $ "#collection .text-container"
  textContainer.find("#painting-title").text mainImage["Title"]
  textContainer.find("#painting-date").text mainImage["Year Produced"]
  textContainer.find("#painting-style").text mainImage["Style"]
  textContainer.find("#painting-genre").text mainImage["Medium"]
  if data.images.length > 0
    $("#collection .image")
    .css "background-image", "url('https://s3.amazonaws.com/immersiongallery/gallery/" +
      data.images[0]["UUID"] + ".jpg')"
  loadImages data.images

exhibitImages = []
loadImages = (images) ->
  exhibitImages = images
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
    info = exhibitImages[currentIndex]
    infoFrame.find("#frame-title").text(info["Title"])
    infoFrame.find("#artist").text(info["Artist"])
    infoFrame.find("#date").text(info["Year Produced"])
    panelSingle.fadeIn(150)
    panelSingle.find("#central-image")
      .css "background-image", "url(#{$(this).find(".image").prop("src")})"
  panelSingle.find("#left-image").on "click", ->
    infoFrame = panelSingle.find("#info-frame")
    return if currentIndex == 0
    currentIndex -= 1
    info = exhibitImages[currentIndex]
    infoFrame.fadeOut 200
    panelSingle.find("#central-image").fadeOut 200, ->
      infoFrame.find("#frame-title").text(info["Title"])
      infoFrame.find("#artist").text(info["Artist"])
      infoFrame.find("#date").text(info["Year Produced"])
      #infoFrame.find("#medium").text(info.medium)
      $(this)
        .css "background-image", "url(https://s3.amazonaws.com/immersiongallery/gallery/" +
          info["UUID"] + ".jpg)"
        .fadeIn(150)
      infoFrame.fadeIn 150

  panelSingle.find("#right-image").on "click", ->
    infoFrame = panelSingle.find("#info-frame")
    return if currentIndex == artistImages.length - 1
    currentIndex += 1
    info = exhibitImages[currentIndex]
    infoFrame.fadeOut 200
    panelSingle.find("#central-image").fadeOut 200, ->
      infoFrame.find("#frame-title").text(info["Title"])
      infoFrame.find("#artist").text(info["Artist"])
      infoFrame.find("#date").text(info["Year Produced"])
      #infoFrame.find("#medium").text(info.medium)
      $(this)
      .css "background-image", "url(https://s3.amazonaws.com/immersiongallery/gallery/" +
        info["UUID"] + ".jpg)"
      .fadeIn(150)
      infoFrame.fadeIn 150

  panelSingle.find("#gotoGrid").on "click", ->
    panelSingle.fadeOut 200, ->
      $("#collection__panel-grid").fadeIn 150
