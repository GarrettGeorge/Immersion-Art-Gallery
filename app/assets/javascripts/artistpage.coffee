ready = ->
  setup()
  getArtistData()
  loadImages()

$ document
  .on "turbolinks:load", ->
    return unless $("#artistpage__initContainer").length > 0
    ready()

isFirstCall = true
setup = ->
  $("#gray-nav-bar #title").css "color", "white"
  $("#gray-nav-bar > #logo").css "background", "url(/assets/ImmersionLogo.svg)"
  $("#collection .image").css "display", "block"
  biography = $ "#biography"
  .addClass "biography-hover"

  $("#artistpage__initContainer #biography").mouseenter (event) ->
    $(".gallery__nav-links").css "color", ""
    $("#gray-searchicon").children().each (index, ele) ->
      ele.setAttribute "stroke", "rgb(89,89,104)"
    $("#biography .image").css "display", "none"
    $("#collection").removeClass "collection-hover"

    $("#gray-nav-bar #title").css "color", "white"
    $("#gray-nav-bar > #logo").css "background", "url(/assets/ImmersionLogo.svg)"
    $("#collection .image").css "display", "block"
    biography.addClass("biography-hover")

  $("#biography").mouseleave (event) ->
    return if event.clientX < Math.floor $("#biography").outerWidth()
    if isFirstCall
      biography.css "background-color", ""
      biography.find(".title").css "color", ""
      biography.find(".gallery__nav-links").css "color", ""
      biography.find(".infobox").css "border", ""
      biography.find(".name").css "color", ""
      isFirstCall = false
    biography.removeClass "biography-hover"
    $("#gray-nav-bar #title").css "color", ""
    $("#gray-nav-bar > #logo").css "background", "url(/assets/ImmersionLogoGray.svg)"
    $("#collection .image").css "display", "none"
  .on "click", ->
    $("#artistpage__biographyContainer")
      .css "display", "block"
    $("#gray-nav-bar #title").css "color", ""
    $("#gray-nav-bar > #logo").css "background", "url(/assets/ImmersionLogoGray.svg)"
    $(this).css "left", "-50%"
    $("#artistpage__initContainer #collection").css "left", "100%"
    $(this).one "webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend", ->
      return if this.style.left == "0%"
      $("#artistpage__initContainer").css "z-index", "1"

  $("#artistpage__initContainer #collection").mouseenter (event) ->
    if isFirstCall
      biography.css "background-color", ""
      biography.find(".title").css "color", ""
      biography.find(".gallery__nav-links").css "color", ""
      biography.find(".infobox").css "border", ""
      biography.find(".name").css "color", ""
      isFirstCall = false

    $("#biography .title").removeClass "initial-title"
    biography.removeClass "biography-hover"
    $("#gray-nav-bar #title").css "color", ""
    $("#gray-nav-bar > #logo").css "background", "url(/assets/ImmersionLogoGray.svg)"
    $("#collection .image").css "display", "none"

    $(".gallery__nav-links").css "color", "white"
    $("#gray-searchicon").children().each (index, ele) ->
      ele.setAttribute "stroke", "white"
    $("#biography .image").css "display", "block"
    $("#collection").addClass "collection-hover"

  $("#collection").mouseleave (event) ->
    return if event.clientX > $("#biography").outerWidth()
    $(".gallery__nav-links").css "color", ""
    $("#gray-searchicon").children().each (index, ele) ->
      ele.setAttribute "stroke", "rgb(89,89,104)"
    $("#biography .image").css "display", "none"
    $("#collection").removeClass "collection-hover"
  .on "click", ->
    $("#artistpage__collectionContainer").css "display", "block"
    $(this).css "left", "100%"
    $(".gallery__nav-links").css "color", ""
    $("#gray-searchicon").children().each (index, ele) ->
      ele.setAttribute "stroke", "rgb(89,89,104)"
    $("#collection__panel-grid").css "display", "block"
    $("#artistpage__initContainer #biography").css "left", "-50%"
    $(this).one "webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend", ->
      return if this.style.left == "50%"
      $("#artistpage__initContainer").css "z-index", "1"
      $("#collection__panel-cover-flow").css "transform", "translate(-100%, -50%)"

  $(".nav-back").on "click", ->
    $("#artistpage__biographyContainer, #artistpage__collectionContainer")
      .fadeOut(300)
    $("#artistpage__initContainer").css "z-index", "2"
    $("#artistpage__initContainer #biography").css "left", "0%"
    $("#artistpage__initContainer #collection").css "left", "50%"
    $("#collection__panel-cover-flow").css "transform", "translate(100%, -50%)"
    $("#collection__panel-grid").css "display", ""

firstName = ""
lastName = ""
getArtistData = ->
  href = window.location.href
  artistName = href.substring(href.lastIndexOf("/")+1).split("-")
  firstName = artistName[0]
  lastName = artistName[1]
  $("#collection .image")
  .css "background-image", "url(/assets/#{firstName.toLowerCase()}-#{lastName.toLowerCase()}.jpg)"
  $("#biography .name").text firstName
  $("#collection .name").text lastName
  properName = [firstName, lastName].reduce (acc, ele) ->
    return acc += ele.charAt(0).toUpperCase() + ele.slice(1) + " "
  , ""
  $("#biography-content-title").text properName
  $.ajax
    url: "/immersion/artists/data?artistFirstName=#{firstName}" +
      "&artistLastName=#{lastName}"
    type: "GET"
    dataType: "json"
    success: (data) ->
      loadArtistData data
    failure: (error) ->
      console.log "request failed"

loadArtistData = (artistData) ->
  biography = artistData.biography
  $("#biography-text").html biography.text.replace(/\n/ig, "<br>")
  textContainer = $("#biography .text-container")
  textContainer.find("#birth").text biography.birth
  textContainer.find("#death").text biography.death
  textContainer.find("#nationality").text biography.nationality
  textContainer.find("#art-movement").text biography.artMovement
  textContainer.find("#field").text biography.field

  mainImage = artistData.mainImage
  textContainer = $("#collection .text-container")
  textContainer.find("#painting-title").text mainImage.title
  textContainer.find("#painting-date").text mainImage.date
  textContainer.find("#painting-style").text mainImage.style
  textContainer.find("#painting-medium").text mainImage.medium
  $("#biography .image")
  .css "background-image", "url('https://s3.amazonaws.com/immersiongallery/gallery/" +
    mainImage.url + ".jpg')"

loadImages = ->
  testData = [
    {
      "url": "311c71f0-d334-4527-addb-34feab8c5cb6"
      "title": "Lucifer"
      "date": "1947"
    },
    {
      "url": "490c95a9-ecb0-4d62-92d3-176a405a7651"
      "title": "Blue (Moby Dick)"
      "date": "1943"
    },
    {
      "url": "8c0c0377-b8da-40af-9daf-32a1bb021ebf"
      "title": "Yellow Islands"
      "date": "1952"
    },
    {
      "url": "c3d165a6-7a94-4eed-99d9-27a6acdff383"
      "title": "Untitled"
      "date": "1941"
    },
    {
      "url": "3a5a2eab-a47b-4370-a1af-289be96e1636"
      "title": "Number 1 (Lavender Mist)"
      "date": "1950"
    },
    {
      "url": "9875b09a-717a-4e39-a48d-02f6f6c0f014"
    },
    {
      "url": "01dd67b7-7533-468d-9777-21ef116abfed"
    },
    {
      "url": "c1a02c34-e2d3-4e23-979a-20a2571224c9"
    }
  ]
  createImageElements testData
  # $.ajax
  #   url: "./artists//images"

artistImages = []
createImageElements = (imageData) ->
  artistImages = imageData
  for image, index in imageData
    (() ->
      container = document.createElement "div"
      $(container).addClass "image-container"
      .data("index", index)

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
      overlayDate = document.createElement "div"
      $(overlayDate).text image.date || ""
      .addClass "date"
      $(overlayInfo).append overlayTitle
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
    info = artistImages[currentIndex]
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
    info = artistImages[currentIndex]
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
    return if currentIndex == artistImages.length - 1
    currentIndex += 1
    info = artistImages[currentIndex]
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
        info = artistImages[currentIndex]
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
        return if currentIndex == artistImages.length - 1
        currentIndex += 1
        info = artistImages[currentIndex]
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
