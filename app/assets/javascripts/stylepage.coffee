ready = ->
  setup()
  getStyleData()

$ document
  .on "turbolinks:load", ->
      return unless $("#stylepage__initContainer").length > 0
      ready()

setup = ->
    $("#gray-nav-bar #title").css "color", "white"
    $("#gray-nav-bar > #logo").css "background", "url(/assets/ImmersionLogo.svg)"
    $("#collection .image").css "display", "block"
    description = $ "#description"
    .addClass "description-hover"

    $("#stylepage__initContainer #description").mouseenter (event) ->
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
      $("#stylepage__descriptionContainer").css "display", "block"
      $("#gray-nav-bar #title").css "color", ""
      $("#gray-nav-bar > #logo").css "background", "url(/assets/ImmersionLogoGray.svg)"
      $(this).css "left", "-50%"
      $("#stylepage__initContainer #collection").css "left", "100%"
      $(this).one "webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend", ->
        return if this.style.left == "0%"
        $("#stylepage__initContainer").css "z-index", "1"

    $("#stylepage__initContainer #collection").mouseenter (event) ->
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
      $("#stylepage__collectionContainer").css "display", "block"
      $(this).css "left", "100%"
      $(".gallery__nav-links").css "color", ""
      $("#gray-searchicon").children().each (index, ele) ->
        ele.setAttribute "stroke", "rgb(89,89,104)"
      $("#collection__panel-grid").css "display", "block"
      $("#stylepage__initContainer #description").css "left", "-50%"
      $(this).one "webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend", ->
        return if this.style.left == "50%"
        $("#stylepage__initContainer").css "z-index", "1"
        $("#collection__panel-cover-flow").css "transform", "translate(-100%, -50%)"

    $(".nav-back").on "click", ->
      $("#stylepage__descriptionContainer, #stylepage__collectionContainer")
        .fadeOut(300)
      $("#stylepage__initContainer").css "z-index", "2"
      $("#stylepage__initContainer #description").css "left", "0%"
      $("#stylepage__initContainer #collection").css "left", "50%"
      $("#collection__panel-cover-flow").css "transform", "translate(100%, -50%)"
      $("#collection__panel-grid").css "display", ""

styleImages = []
firstPart = ""
lastPart = ""
getStyleData = ->
  href = window.location.href
  styleName = href.substring(href.lastIndexOf("/")+1).split "-"
  title = styleName.reduce (acc, ele) ->
    return acc += ele.charAt(0).toUpperCase() + ele.slice(1) + " "
  , ""
  console.log title
  $("#description-content-title").text title
  if(styleName.length < 2)
    styleName = href.substring(href.lastIndexOf("/")+1)
    styleName = [
      styleName.substring(0, styleName.length/2),
      styleName.substring(styleName.length/2)
    ]
  firstPart = styleName[0]
  lastPart = styleName[1]
  $("#description .name").text firstPart
  $("#collection .name").text lastPart
  $("#collection .image")
  .css "background-image", "url(/assets/#{href.substring(href.lastIndexOf('/'))})"
  $.ajax
    url: encodeURI("/immersion/styles/data?styleName=#{styleName.join(" ")}")
    type: "GET"
    dataType: "json"
    success: (data) ->
      console.log data
      loadStyleData data
    failure: (error) ->
      console.log "Error reading style data."

loadStyleData = (styleData) ->
  description = styleData.description
  $("#description-text").html(description.text.replace(/\n/g, "<br>"))
  textContainer = $ "#description .text-container"
  description.artists.forEach (artist, index) ->
    textContainer.find("#artist-#{index+1}").prop "href", "../artists/#{artist.href}"
    .html artist.name.replace(/ /, "<br>")

  mainImage = styleData.mainImage
  textContainer = $ "#collection .text-container"
  textContainer.find("#painting-title").text mainImage.title
  textContainer.find("#painting-date").text mainImage.artist
  textContainer.find("#painting-style").text mainImage.date
  textContainer.find("#painting-genre").text mainImage.medium
  $("#description .image")
  .css "background-image", "url('https://s3.amazonaws.com/immersiongallery/gallery/" +
    mainImage.url + ".jpg')"
  loadImages styleData.images


loadImages = (images) ->
  styleImages = images
  for image, index in images
    (() ->
      container = document.createElement "div"
      $(container).addClass "image-container"
      .data "index", index

      img = document.createElement "img"
      $(img).addClass "image"
      .prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" +
        image.url + ".jpg"

      imgOverlay = document.createElement "div"
      $(imgOverlay).addClass "image-overlay"
      overlayInfo = document.createElement "div"
      $(overlayInfo).addClass "info"
      overlayTitle = document.createElement "div"
      $(overlayTitle).text image.title || ""
      .addClass "title"
      overlayArtist = document.createElement "div"
      $(overlayArtist).text image.artist || ""
      .addClass "artist"
      overlayDate = document.createElement "div"
      $(overlayDate).text image.date || ""
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
    info = styleImages[currentIndex]
    infoFrame.find("#frame-title").text(info.title)
    infoFrame.find("#artist").text(info.artist)
    infoFrame.find("#date").text(info.date)
    #infoFrame.find("#medium").text(info.medium)
    panelSingle.css "display", "block"
    panelSingle.find("#central-image").fadeIn 150
    $("#central-image-container").css "left", "calc(50% + #{infoFrame.outerWidth()/2 + 25}px)"
    panelSingle.find("#central-image")
      .prop "src", "#{$(this).find(".image").prop("src")}"

  panelSingle.find("#left-image").on "click", ->
    infoFrame = panelSingle.find("#info-frame")
    return if currentIndex == 0
    currentIndex -= 1
    info = styleImages[currentIndex]
    infoFrame.fadeOut 200
    panelSingle.find("#central-image").fadeOut 200, ->
      infoFrame.find("#frame-title").text(info.title)
      infoFrame.find("#artist").text(info.artist)
      infoFrame.find("#date").text(info.date)
      #infoFrame.find("#medium").text(info.medium)
      $(this)
      .prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" +
        info.url + ".jpg"
      .fadeIn 150
      infoFrame.fadeIn 150
      $("#central-image-container").css "left", "calc(50% + #{infoFrame.outerWidth()/2 + 25}px)"

  panelSingle.find("#right-image").on "click", ->
    infoFrame = panelSingle.find("#info-frame")
    return if currentIndex == styleImages.length - 1
    currentIndex += 1
    info = styleImages[currentIndex]
    infoFrame.fadeOut 200
    panelSingle.find("#central-image").fadeOut 200, ->
      infoFrame.find("#frame-title").text(info.title)
      infoFrame.find("#artist").text(info.artist)
      infoFrame.find("#date").text(info.date)
      #infoFrame.find("#medium").text(info.medium)
      $(this)
      .prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" +
        info.url + ".jpg"
      .fadeIn 150
      infoFrame.fadeIn 150
      $("#central-image-container").css "left", "calc(50% + #{infoFrame.outerWidth()/2 + 25}px)"

  $(document).keyup (e) ->
    switch e.which
      when 37
        infoFrame = panelSingle.find("#info-frame")
        return if currentIndex == 0
        currentIndex -= 1
        info = styleImages[currentIndex]
        infoFrame.fadeOut 200
        panelSingle.find("#central-image").fadeOut 200, ->
          infoFrame.find("#frame-title").text(info.title)
          infoFrame.find("#artist").text(info.artist)
          infoFrame.find("#date").text(info.date)
          #infoFrame.find("#medium").text(info.medium)
          $(this)
            .prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" +
              info.url + ".jpg"
            .fadeIn 150
          infoFrame.fadeIn 150
          $("#central-image-container").css "left", "calc(50% + #{infoFrame.outerWidth()/2 + 25}px)"
      when 39
        infoFrame = panelSingle.find("#info-frame")
        return if currentIndex == styleImages.length - 1
        currentIndex += 1
        info = styleImages[currentIndex]
        infoFrame.fadeOut 200
        panelSingle.find("#central-image").fadeOut 200, ->
          infoFrame.find("#frame-title").text(info.title)
          infoFrame.find("#artist").text(info.artist)
          infoFrame.find("#date").text(info.date)
          #infoFrame.find("#medium").text(info.medium)
          $("#central-image-container").css "left", "calc(50% + #{infoFrame.outerWidth()/2 + 25}px)"
          $(this)
          .prop "src", "https://s3.amazonaws.com/immersiongallery/gallery/" +
            info.url + ".jpg"
          .fadeIn 150
          infoFrame.fadeIn 150
          $("#central-image-container").css "left", "calc(50% + #{infoFrame.outerWidth()/2 + 25}px)"
      else return

  panelSingle.find("#gotoGrid").on "click", ->
    panelSingle.fadeOut 200, ->
      $("#collection__panel-grid").fadeIn 150, ->
        $("#collection__panel-single #central-image").css "display", "none"
