# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

count = 0
ready = ->
  return if count > 0
  setup()
  count += 1

$ document
  .on "turbolinks:load", ->
    return unless $("#adminpage__initContainer").length > 0
    ready()

artArray = []
empArray = []
nonEmpArray = []
exhibitsArray = []
exhibitArtsArray = []

currentArtIndex = 0
currentEmpIndex = 0
currentNonEmpIndex = 0
currentExhibitIndex = 0

currentExhibitArt = {}

isUpdating = false
isSearchingExhibitArt = false
setup = ->
  $("#adminpage__gotoArtwork").on "click", ->
    $(this).fadeOut(250)
    $("#adminpage__gotoEmployees, #adminpage__gotoNonEmployees, #adminpage__gotoExhibits")
    .fadeOut(250)
    $("#adminpage__artwork").fadeIn(250)

  $("#adminpage__gotoEmployees").on "click", ->
    $(this).fadeOut(250)
    $("#adminpage__gotoArtwork, #adminpage__gotoExhibits, #adminpage__gotoNonEmployees")
      .fadeOut(250)
    $("#adminpage__employees").fadeIn(250)

  $("#adminpage__gotoNonEmployees").on "click", ->
    $(this).fadeOut(250)
    $("#adminpage__gotoArtwork, #adminpage__gotoExhibits, #adminpage__gotoEmployees")
      .fadeOut(250)
    $("#adminpage__nonemployees").fadeIn(250)

  $("#adminpage__gotoExhibits").on "click", ->
    $(this).fadeOut(250)
    $("#adminpage__gotoArtwork, #adminpage__gotoEmployees, #adminpage__gotoNonEmployees")
      .fadeOut(250)
    $("#adminpage__exhibits").fadeIn(250)

  $(".back-to-admin").on "click", ->
    $("#adminpage__gotoEmployees, #adminpage__gotoArtwork, #adminpage__gotoExhibits, #adminpage__gotoNonEmployees")
    .fadeIn(250)
    $("#adminpage__employees, #adminpage__artwork, #adminpage__nonemployees, #adminpage__exhibits")
    .fadeOut(250)

  $("#add-art").on "click", addArtModal

  $("#add-emp").on "click", addEmpModal

  $("#add-non-emp").on "click", addNonEmpModal

  $("#add-exhibit").on "click", addExhibitModal

  $("#overlay-art form input:last-child").on "click", ->
    if isUpdating
      editArtRow($(this.parentElement))
    else
      addArt($(this.parentElement))

  $("#overlay-employee form input:last-child").on "click", ->
    if isUpdating
      editEmployeeRow($(this.parentElement))
    else
      addEmployee($(this.parentElement))

  $("#overlay-non-employee form input:last-child").on "click", ->
    if isUpdating
      editNonEmployeeRow($(this.parentElement))
    else
      addNonEmployee($(this.parentElement))

  $("#overlay-exhibit > .modal > form > input:last-child").on "click", ->
    if isUpdating
      editExhibitRow($(this.parentElement))
    else
      addExhibit($(this.parentElement))

  $("#exhibit-add-art").on "click", ->
    $("#modal-gallery form input:last-child").val "Search"
    $("#modal-gallery").fadeIn 250
    $(this.parentElement).fadeOut 250
    $(this.parentElement.parentElement).css "width", "80%"

  $("#backToExhibit").on "click", ->
    $("#modal-gallery").fadeOut 250
    $("#overlay-exhibit form").fadeIn 250
    $(this.parentElement.parentElement).css "width", "50%"


  $("#overlay-non-employee form #donor_amount").change ->
    if $(this).val().match(/[0-9]/ig)
      if $(this).val() > 0
        $(this.parentElement).find("#type").val "Donor"
      else
        $(this.parentElement).find("#type").val "Member"
    else if $(this).val() == ""
      $(this).val "0"
      $(this.parentElement).find("#type").val "Member"


  $("#search-art").on "click", ->
    if $("#adminpage__artwork form").css("display") == "none"
      $("#adminpage__artwork form").slideDown 350
    else
      $("#adminpage__artwork form").slideUp 350

  $("#search-employee").on "click", ->
    if $("#adminpage__employees form").css("display") == "none"
      $("#adminpage__employees form").slideDown 350
    else
      $("#adminpage__employees form").slideUp 350

  $("#search-non-employee").on "click", ->
    if $("#adminpage__nonemployees form").css("display") == "none"
      $("#adminpage__nonemployees form").slideDown 350
    else
      $("#adminpage__nonemployees form").slideUp 350

  $("#search-exhibits").on "click", ->
    if $("#adminpage__exhibits form").css("display") == "none"
      $("#adminpage__exhibits form").slideDown 350
    else
      $("#adminpage__exhibits form").slideUp 350

  $("#adminpage__artwork form input:last-child").on "click", ->
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
        artArray = data
        $("#adminpage__artwork .table-row").each (index, ele) ->
          $(this).remove()
        buildArtTable(data)
      failure: (data) ->
        alert "Search failed. Try again."

  $("#adminpage__employees form input:last-child").on "click", ->
    form = $(this.parentElement)
    params = []
    name = form.find("#employee_name").val()
    if name != "" then params.push {
      qs: "name"
      val: name
    }
    position = form.find("#position").val()
    if position != "" then params.push {
      qs: "position"
      val: position
    }
    salary = form.find("#salary").val()
    if salary != "" then params.push {
      qs: "salary"
      val: salary
    }
    birthDate = form.find("#birth_date").val()
    if birthDate != "" then params.push {
      qs: "birthDate"
      val: birthDate
    }
    ssn = form.find("#ssn").val()
    if ssn != "" then params.push {
      qs: "ssn"
      val: ssn
    }
    urls = ""
    for p in params
      urls += "#{p.qs}=#{p.val}&"

    if params.length == 0
      urls = "all=true"

    console.log "/immersion/admin/search_employee?" + urls
    $.ajax
      url: "/immersion/admin/search_employee?" + urls
      type: "GET"
      format: "json"
      success: (data) ->
        console.log data
        empArray = data
        $("#adminpage__employees .table-row").each (index, ele) ->
          $(this).remove()
        buildEmployeeTable(data)
      failure: (data) ->
        alert "Search failed. Try again."

  $("#adminpage__nonemployees form input:last-child").on "click", ->
    form = $(this.parentElement)
    params = []
    name = form.find("#non_emp_name").val()
    if name != "" then params.push {
      qs: "name"
      val: name
    }
    type = form.find("#type").val()
    if type != "" then params.push {
      qs: "type"
      val: type
    }
    joinDate = form.find("#join_date").val()
    if joinDate != "" then params.push {
      qs: "join"
      val: joinDate
    }
    donorAmount = form.find("#donor_amount").val()
    if donorAmount != "" then params.push {
      qs: "donor_amount"
      val: donorAmount
    }
    id = form.find("#non_emp_id").val()
    if id != "" then params.push {
      qs: "id"
      val: id
    }

    urls = ""
    for p in params
      urls += "#{p.qs}=#{p.val}&"

    if params.length == 0
      urls = "all=true"

    $.ajax
      url: "/immersion/admin/search_non_employee?" + urls
      type: "GET"
      format: "json"
      success: (data) ->
        console.log data
        nonEmpArray = data
        $("#adminpage__nonemployees .table-row").each (index, ele) ->
          $(this).remove()
        buildNonEmployeeTable(data)
      failure: (data) ->
        alert "Search failed. Try again."

  $("#adminpage__exhibits form input:last-child").on "click", ->
    form = $(this.parentElement)
    params = []
    name = form.find("#exhibit_title").val()
    if name != "" then params.push {
      qs: "Title"
      val: name
    }
    start = form.find("#start_date").val()
    if start != "" then params.push {
      qs: "start_date"
      val: start
    }
    end = form.find("#end_date").val()
    if end != "" then params.push {
      qs: "end_date"
      val: end
    }
    mainImg = form.find("#main_image").val()
    if mainImg != "" then params.push {
      qs: "main_image"
      val: mainImg
    }

    urls = ""
    for p in params
      urls += "#{p.qs}=#{p.val}&"

    if params.length == 0
      urls = "all=true"

    $.ajax
      url: "/immersion/admin/search_exhibit?" + urls
      type: "GET"
      format: "json"
      success: (data) ->
        # console.log data
        # exhibitsArray = data
        # $("#adminpage__exhibits .table-row").each (index, ele) ->
        #   $(this).remove()
        # buildExhibitTabledata)
      failure: (data) ->
        alert "Search failed. Try again."

  $("#overlay-art, #overlay-employee, #overlay-non-employee, #overlay-exhibit")
  .on "click", (e)->
    return unless e.target == this
    $(this).fadeOut 200, ->
      $(this).find("form").trigger("reset")

  $.ajax
    url: "/immersion/admin/data"
    type: "GET"
    format: "json"
    success: (data) ->
      console.log data
      artArray = data.art
      empArray = data.employees
      nonEmpArray = data["non_employees"]
      exhibitsArray = data.exhibits
      exhibitArtsArray = data.art
      buildArtTable(data.art)
      buildEmployeeTable(data.employees)
      buildNonEmployeeTable(data["non_employees"])
      buildExhibitArtTable(data.art)
      buildExhibitTable(data.exhibits)
    failures: (err) ->
      console.log "Error requesting data"

  $("#modal-gallery form input:last-child").on "click", ->
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
      isSearchingExhibitArt = false
    else
      isSearchingExhibitArt = true


    $.ajax
      url: "/immersion/search/input?" + urls
      type: "GET"
      format: "json"
      success: (data) ->
        console.log data
        exhibitArtsArray = data
        $("#modal-gallery .table-row").each (index, ele) ->
            $(this).remove()
        buildExhibitArtTable(data)
      failure: (data) ->
        alert "Search failed. Try again."

addArtModal = ->
  isUpdating = false
  $("#overlay-art form input:last-child").val "Add To Collection"
  $("#overlay-art").fadeIn 200, ->
    $("#overlay-art #artwork_title").focus()

addEmpModal = ->
  isUpdating = false
  $("#overlay-employee form input:last-child").val "Add Employee"
  $("#overlay-employee").fadeIn 200, ->
    $("#overlay-employee #emp_name").focus()

addNonEmpModal = ->
  isUpdating = false
  $("#overlay-non-employee form input:last-child").val "Add Person"
  d = new Date()
  $("#overlay-non-employee form #join_date").val(d.toISOString().substring(0, 10))
  $("#overlay-non-employee form #donor_amount").val "0"
  $("#overlay-non-employee").fadeIn 200, ->
    $(this).find("#non_emp_name").focus()

addExhibitModal = ->
  isUpdating = false
  currentExhibitArt = {}
  $("#modal-gallery .table-row").each (index, ele) ->
      $(this).remove()
  buildExhibitArtTable(artArray)
  $("#overlay-exhibit form input:last-child").val "Create Exhibit"
  $("#overlay-exhibit").fadeIn 200, ->
    $("#overlay-exhibit #exhibit_title").focus()


addArt = (form) ->
  title = form.find("#artwork_title").val()
  if title == ""
    title = "Untitled"
  artist = form.find("#artist").val()
  date = form.find("#date").val()
  style = form.find("#artwork_style").val()
  medium = form.find("#medium").val()
  uuid = form.find("#uuid").val()
  if !uuid.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i)
    alert("UUID must match RFC4122.\n/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/")
    $("#overlay-art form input:last-child").prop("disabled", false)
    return
  $.ajax
    url: "/immersion/admin/add_art?artwork_title=#{title}&artist=#{artist}&date=#{date}&artwork_style=" +
      "#{style}&medium=#{medium}&uuid=#{uuid}"
    type: "POST"
    format: "json"
    success: (data) ->
      console.log data
      if data.success
        $("#overlay-art").click()
        artArray.push(data.art)
        createArtTableRow(data.art)
      else if data.failure
        alert("Failed to insert art into database")
      $("#overlay-art form input:last-child").prop("disabled", false)
    failures: (err) ->
      console.log "Error requesting data"
      $("#overlay-art form input:last-child").prop("disabled", false)

addEmployee = (form) ->
  $("#overlay-employee form input:last-child").prop("disabled", false)
  name = form.find("#emp_name").val()
  position = form.find("#position").val()
  salary = form.find("#salary").val()
  birth = form.find("#birth_date").val()
  ssn = form.find("#ssn").val()
  username = form.find("#username").val()
  p1 = form.find("#password1").val()
  p2 = form.find("#password2").val()
  if !birth.match(/[0-9]{4}-[0-9]{2}-[0-9]{2}/)
    alert("Enter birth date in the form YYYY-MM-DD.")
    return
  if name == ""
    alert("Enter a name please.")
    return
  if !ssn.match(/[0-9]{9}/)
    alert("Enter a valid social security number. No hypens needed.")
    return
  if username == "" || p1 == ""
    alert("Enter a username and password.")
    return
  if p1 != p2
    alert("Passwords don't match.")
    return

  $.ajax
    url: "/immersion/admin/add_employee?name=#{name}&position=#{position}" +
      "&salary=#{salary}&birth=#{birth}&ssn=#{ssn}&username=#{username}" +
      "&password=#{p1}"
    type: "POST"
    format: "json"
    success: (data) ->
      console.log data
      if data.success
        $("#overlay-employee").click()
        empArray.push(data.employee)
        createEmpTableRow(data.employee)
      else if data.failure
        if data.failure == "t"
          alert("Failed to insert employee into database")
        else if data.failure == "username"
          alert("Username already in database.")
      $("#overlay-employee form input:last-child").prop("disabled", false)
    failure: (error) ->
      console.log "Error: #{error}"
      $("#overlay-employee form input:last-child").prop("disabled", false)

addNonEmployee = (form) ->
  name = form.find("#non_emp_name").val()
  type = form.find("#type").val()
  joinDate = form.find("#join_date").val()
  donorAmount = form.find("#donor_amount").val()
  if name == ""
    alert "Person must have a valid name."
    return
  if !joinDate.match(/[0-9]{4}-[0-9]{2}-[0-9]{2}/)
    alert("Enter birth date in the form YYYY-MM-DD.")
    return
  if !donorAmount.match(/[0-9]/ig) || donorAmount < 0
    alert("Enter a valid donor amount.")
    return

  $.ajax
    url: "/immersion/admin/add_non_employee?name=#{name}&type=#{type}" +
      "&join=#{joinDate}&donor_amount=#{donorAmount}"
    type: "POST"
    format: "json"
    success: (data) ->
      console.log data
      if data.success
        $("#overlay-non-employee").click()
        nonEmpArray.push(data.nonEmployee)
        createNonEmpTableRow(data.nonEmployee)
      else if data.failure
        alert("Failed to insert person into database")
    failure: (error) ->
      console.log "Error: #{error}"

addExhibit = (form) ->
  title = form.find("#exhibit_title").val()
  if title == "" || title.indexOf(":") == -1
    alert("Exhibit must have a name and a colon to separate a title and subtitle.")
    return
  start = form.find("#start_date").val()
  if !start.match(/[0-9]{4}-[0-9]{2}-[0-9]{2}/)
    alert("Enter start date in the form YYYY-MM-DD.")
    return
  end = form.find("#end_date").val()
  if !end.match(/[0-9]{4}-[0-9]{2}-[0-9]{2}/)
    alert("Enter end date in the form YYYY-MM-DD.")
    return
  mainImg = form.find("#main_image").val()
  if !mainImg.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i)
    alert("Enter main image UUID. Must match RFC4122.")
    return

  description = form.find("#description").val()

  $.ajax
    url: "/immersion/admin/add_exhibit?title=#{title}&start=#{start}&end=#{end}&main_image=#{mainImg}&description=#{description}" +
      (if Object.keys(currentExhibitArt).length > 0 then "&data=" + JSON.stringify currentExhibitArt else "")
    type: "POST"
    format: "json"
    success: (data) ->
      console.log data
      if data.success
        $("#overlay-exhibit").click()
        hash = {}
        data.exhibit.art.forEach (ele, index) ->
          hash[ele["UUID"]] = true
        data.exhibit["art_hash"] = hash
        exhibitsArray.push(data.exhibit)
        createExhibitTableRow(data.exhibit)
      else if data.failure
        if data.failure == "title"
          alert("Exhibit with that title already exists.")
        else if data.failure == "main_image"
          alert("That main image does not exist in the database.")
        else
          alert("Failed to insert exhibit into database")
    failures: (err) ->
      console.log "Error requesting data"

buildArtTable = (art)->
  for p, index in art
    (() ->
      createArtTableRow(p, false)
    )()

buildEmployeeTable = (emps) ->
  for p, index in emps
    (() ->
      createEmpTableRow(p)
    )()

buildNonEmployeeTable = (nonEmps) ->
  for nE in nonEmps
    createNonEmpTableRow(nE)

buildExhibitTable = (exhibits) ->
  for e, index in exhibits
    hash = {}
    e.art.forEach (ele, index) ->
      hash[ele["UUID"]] = true
    exhibitsArray[index]["art_hash"] = hash
    createExhibitTableRow(e)

buildExhibitArtTable = (art) ->
  for a in art
    createArtTableRow(a, true)

createArtTableRow = (p, forExhibit) ->
  row = document.createElement "div"
  $(row).addClass "table-row"
  .data "uuid", p["UUID"]

  col1 = document.createElement "div"
  $(col1).addClass "table-row-col"

  title = document.createElement "div"
  $(title).addClass "table-row-title"
  .text p["Title"]

  artist = document.createElement "div"
  $(artist).addClass "table-row-artist"
  .html "<b>Artist: </b>" + p["Artist"]

  date = document.createElement "div"
  $(date).addClass "table-row-date"
  .html "<b>Date: </b>" + p["Year Produced"]

  col2 = document.createElement "div"
  $(col2).addClass "table-row-col"

  style = document.createElement "div"
  $(style).addClass "table-row-style"
  .html "<b>Style: </b>" + p["Style"]

  medium = document.createElement "div"
  $(medium).addClass "table-row-medium"
  .html "<b>Medium: </b>" + p["Medium"]

  uuid = document.createElement "div"
  $(uuid).addClass "table-row-uuid"
  .html "<b>UUID: </b>" + p["UUID"]

  col1.appendChild title
  col1.appendChild artist
  col1.appendChild date
  row.appendChild col1
  col2.appendChild style
  col2.appendChild medium
  col2.appendChild uuid
  row.appendChild col2

  if forExhibit
    checkmark = document.createElement "div"
    $(checkmark).addClass "table-row-checkmark"
    row.appendChild checkmark
    $("#modal-gallery").append row
    index = $(row).index() - 2
    if !artArray[index]
      return
    if (currentExhibitArt["#{artArray[index]['UUID']}"] && !isSearchingExhibitArt) ||
    (index < exhibitArtsArray.length &&
     currentExhibitArt[exhibitArtsArray[index]["UUID"]] &&
     isSearchingExhibitArt
    )
      $(row).find(".table-row-checkmark").css "display", "block"
      .css "left", "-5%"

    $(row).on "click", ->
      index = $(row).index() - 2
      if $(this).find(".table-row-checkmark").css("display") == "none"
        currentExhibitArt["#{exhibitArtsArray[index]["UUID"]}"] = true
        $(this).find(".table-row-checkmark").fadeIn 150
        .css "left", "-5%"
      else
        delete currentExhibitArt["#{exhibitArtsArray[index]["UUID"]}"]
        $(this).find(".table-row-checkmark").fadeOut 150
        .css "left", "0%"
  else
    buttons = document.createElement "div"
    $(buttons).addClass "table-row-buttons"

    edit = document.createElement "div"
    $(edit).addClass "button"
    remove = document.createElement "div"
    $(remove).addClass "button"

    buttons.appendChild edit
    buttons.appendChild remove
    row.appendChild buttons
    $("#adminpage__artwork .table").append row

    $(row).find(".table-row-buttons > div:first-child").on "click", ->
      openEditArtRow($(this.parentElement.parentElement).index()-1)

    $(row).find(".table-row-buttons > div:last-child").on "click", ->
      r = confirm("Are you sure you want to delete that art piece?");
      if r
        index = $(this.parentElement.parentElement).index() - 1

        $.ajax
          url: "/immersion/admin/remove_art?uuid=#{artArray[index]["UUID"]}"
          type: "POST"
          format: "json"
          success: (data) ->
            console.log data
            if data.success
              $("#adminpage__artwork .table-row:nth-child(#{index+2})").remove()
            else if data.failure
              if data.failure == "in_exhibit"
                alert("Cannot remove. Art piece is currently part of an exhibit.")
              else
                alert("Failed to remove art from database")

          failure: (err) ->
            console.log "error - #{error}"

createEmpTableRow = (p) ->
  row = document.createElement "div"
  $(row).addClass "table-row"

  col1 = document.createElement "div"
  $(col1).addClass "table-row-col"

  name = document.createElement "div"
  $(name).addClass "table-row-name"
  .text p["Name"]

  username = document.createElement "div"
  $(username).addClass "table-row-username"
  .html "<b>Username: </b>" + p["User_Name"]

  position = document.createElement "div"
  $(position).addClass "table-row-position"
  .html "<b>Position: </b>" + p["Position"]

  salary = document.createElement "div"
  $(salary).addClass "table-row-salary"
  .html "<b>Salary: </b>$" + p["Pay"]

  id = document.createElement "div"
  $(id).addClass "table-row-id"
  .html "<b>People ID: </b>" + p["ID"]

  col2 = document.createElement "div"
  $(col2).addClass "table-row-col"

  birth = document.createElement "div"
  $(birth).addClass "table-row-birth"
  .html "<b>Birth Date: </b>" + p["Birth Date"]

  ssn = document.createElement "div"
  $(ssn).addClass "table-row-ssn"
  .html "<b>SSN: </b>" + p["SSN"]

  buttons = document.createElement "div"
  $(buttons).addClass "table-row-buttons"

  edit = document.createElement "div"
  $(edit).addClass "button"
  remove = document.createElement "div"
  $(remove).addClass "button"

  buttons.appendChild edit
  buttons.appendChild remove

  col1.appendChild name
  col1.appendChild position
  col1.appendChild salary
  col1.appendChild username
  row.appendChild col1
  col2.appendChild birth
  col2.appendChild ssn
  col2.appendChild id
  row.appendChild col2
  row.appendChild buttons
  $("#adminpage__employees .table").append row

  $(row).find(".table-row-buttons > div:first-child").on "click", ->
    openEditEmpRow($(this.parentElement.parentElement).index() - 1)

  $(row).find(".table-row-buttons > div:last-child").on "click", ->
    r = confirm("Are you sure you want to delete that employee?");
    if r
      index = $(this.parentElement.parentElement).index() - 1

      $.ajax
        url: "/immersion/admin/remove_employee?id=#{empArray[index]["People_ID1"]}"
        type: "POST"
        format: "json"
        success: (data) ->
          console.log data
          if data.success
            $("#adminpage__employees .table-row:nth-child(#{index+2})").remove()
          else if data.failure
            alert("Failed to remove employee from database")
        failure: (err) ->
          console.log "error - #{error}"

createNonEmpTableRow = (p) ->
  row = document.createElement "div"
  $(row).addClass "table-row"

  col1 = document.createElement "div"
  $(col1).addClass "table-row-col"

  name = document.createElement "div"
  $(name).addClass "table-row-name"
  .text p["Name"]

  type = document.createElement "div"
  $(type).addClass "table-row-type"
  .html "<b>Type: </b>" + p["Type"]

  col2 = document.createElement "div"
  $(col2).addClass "table-row-col"

  joinDate = document.createElement "div"
  $(joinDate).addClass "table-row-join-date"
  .html "<b>Join Date: </b>" + p["join_date"]

  id = document.createElement "div"
  $(id).addClass "table-row-id"
  .html "<b>ID: </b>" + p["ID"]

  buttons = document.createElement "div"
  $(buttons).addClass "table-row-buttons"

  edit = document.createElement "div"
  $(edit).addClass "button"
  remove = document.createElement "div"
  $(remove).addClass "button"

  buttons.appendChild edit
  buttons.appendChild remove

  col1.appendChild name
  col1.appendChild type
  if p["donor_amount"] > 0
    donorAmount = document.createElement "div"
    $(donorAmount).addClass "table-row-donor"
    .html "<b>Donor Amount:</b> $" + p["donor_amount"]
    col1.appendChild donorAmount
  row.appendChild col1
  col2.appendChild joinDate
  col2.appendChild id
  row.appendChild col2
  row.appendChild buttons
  $("#adminpage__nonemployees .table").append row

  $(row).find(".table-row-buttons div:first-child").on "click", ->
    openEditNonEmpRow($(this.parentElement.parentElement).index() - 1)

  $(row).find(".table-row-buttons div:last-child").on "click", ->
    r = confirm("Are you sure you want to delete that person?");
    if r
      index = $(this.parentElement.parentElement).index() - 1
      $.ajax
        url: "/immersion/admin/remove_non_employee?id=#{nonEmpArray[index]["People_ID1"]}"
        type: "POST"
        format: "json"
        success: (data) ->
          console.log data
          if data.success
            $("#adminpage__nonemployees .table-row:nth-child(#{index+2})").remove()
          else if data.failure
            alert("Failed to remove person from database")
        failure: (err) ->
          console.log "error - #{error}"

createExhibitTableRow = (p) ->
  row = document.createElement "div"
  $(row).addClass "table-row"

  col1 = document.createElement "div"
  $(col1).addClass "table-row-col"

  name = document.createElement "div"
  $(name).addClass "table-row-exhibit-title"
  .text p["Title"]

  start = document.createElement "div"
  $(start).addClass "table-row-exhibit-start"
  .html "<b>Start Date: </b>" + p["start_date"]

  end = document.createElement "div"
  $(end).addClass "table-row-exhibit-end"
  .html "<b>End Date: </b>" + p["end_date"]

  col2 = document.createElement "div"
  $(col2).addClass "table-row-col"

  mainImg = document.createElement "div"
  $(mainImg).addClass "table-row-main-image"
  .html "<b>Main Image: </b>" + p["main_image"]

  buttons = document.createElement "div"
  $(buttons).addClass "table-row-buttons"

  edit = document.createElement "div"
  $(edit).addClass "button"
  remove = document.createElement "div"
  $(remove).addClass "button"

  buttons.appendChild edit
  buttons.appendChild remove

  col1.appendChild name
  col1.appendChild start
  col1.appendChild end
  row.appendChild col1
  col2.appendChild mainImg
  row.appendChild col2
  row.appendChild buttons
  $("#adminpage__exhibits .table").append row

  $(row).find(".table-row-buttons > div:first-child").on "click", ->
    openEditExhibitRow($(this.parentElement.parentElement).index()-1)

  $(row).find(".table-row-buttons > div:last-child").on "click", ->
    r = confirm("Are you sure you want to delete this exhibit?");
    if r
      index = $(this.parentElement.parentElement).index() - 1

      console.log exhibitsArray[index]["ID"]
      $.ajax
        url: "/immersion/admin/remove_exhibit?id=#{exhibitsArray[index]["ID"]}" +
        if Object.keys(exhibitsArray[index]["art_hash"]).length > 0 then "&data=" + JSON.stringify exhibitsArray[index]["art_hash"] else ""
        type: "POST"
        format: "json"
        success: (data) ->
          console.log data
          if data.success
            $("#adminpage__exhibits .table-row:nth-child(#{index+2})").remove()
          else if data.failure
            alert("Failed to remove exhibit from database")

        failure: (err) ->
          console.log "error - #{error}"


# Edit functions for art table

updateArtTableRow = (index, artPiece) ->
  row = $("#adminpage__artwork .table-row:nth-child(#{index+2})")
  row.find(".table-row-title").text artPiece["Title"]
  row.find(".table-row-artist").html "<b>Artist:</b> " + artPiece["Artist"]
  row.find(".table-row-date").html "<b>Date:</b> " + artPiece["Year Produced"]
  row.find(".table-row-style").html "<b>Style:</b> " + artPiece["Style"]
  row.find(".table-row-medium").html "<b>Medium:</b> " + artPiece["Medium"]
  row.find(".table-row-uuid").html "<b>UUID:</b> " + artPiece["UUID"]

openEditArtRow = (index) ->
  isUpdating = true
  currentArtIndex = index
  form = $("#overlay-art form")
  form.find("#artwork_title").val artArray[index]["Title"]
  form.find("#artist").val artArray[index]["Artist"]
  form.find("#date").val artArray[index]["Year Produced"]
  form.find("#artwork_style").val artArray[index]["Style"]
  form.find("#medium").val artArray[index]["Medium"]
  form.find("#uuid").val artArray[index]["UUID"]
  .prop "disabled", true
  form.find("input:last-child").val "Update Details"
  .one "click", ->
    editArtRow(form)
  $("#overlay-art").fadeIn 200, ->
    $("#overlay-art #artwork_title").focus()

editArtRow = (form) ->
  isUpdating = true
  title = form.find("#artwork_title").val()
  if title == ""
    title = "Untitled"
  artist = form.find("#artist").val()
  date = form.find("#date").val()
  style = form.find("#artwork_style").val()
  medium = form.find("#medium").val()
  uuid = form.find("#uuid").val()
  if !uuid.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i)
    alert("UUID must match RFC4122.\n/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/")
    $("#overlay-art form input:last-child").prop("disabled", false)
    return
  $.ajax
    url: "/immersion/admin/edit_art?artwork_title=#{title}&artist=#{artist}&date=#{date}&artwork_style=" +
      "#{style}&medium=#{medium}&uuid=#{uuid}"
    type: "POST"
    format: "json"
    success: (data) ->
      console.log data
      if data.success
        $("#overlay-art").click()
        artArray[currentArtIndex] = data.art
        updateArtTableRow(currentArtIndex, data.art)
      else if data.failure
        alert("Failed to insert art into database")
      $("#overlay-art form input:last-child").prop("disabled", false)
    failures: (err) ->
      console.log "Error requesting data"
      $("#overlay-art form input:last-child").prop("disabled", false)

# Edit functions for employees table

openEditEmpRow = (index) ->
  isUpdating = true
  currentEmpIndex = index
  form = $("#overlay-employee form")
  form.find("#emp_name").val empArray[index]["Name"]
  form.find("#position").val empArray[index]["Position"]
  form.find("#salary").val empArray[index]["Pay"]
  form.find("#birth_date").val empArray[index]["Birth Date"]
  form.find("#ssn").val empArray[index]["SSN"]
  form.find("#username").val empArray[index]["User_Name"]
  form.find("input:last-child").val "Update Details"
  $("#overlay-employee").fadeIn 200, ->
    $("#overlay-employee #emp_name").focus()

editEmployeeRow = (form) ->
  isUpdating = true
  $("#overlay-employee form input:last-child").prop("disabled", false)
  name = form.find("#emp_name").val()
  position = form.find("#position").val()
  salary = form.find("#salary").val()
  birth = form.find("#birth_date").val()
  ssn = form.find("#ssn").val()
  username = form.find("#username").val()
  p1 = form.find("#password1").val()
  p2 = form.find("#password2").val()
  if !birth.match(/[0-9]{2}-[0-9]{2}-[0-9]{4}/)
    alert("Enter birth date in the form /[0-9]{2}-[0-9]{2}-[0-9]{4}/")
  if name == ""
    alert("Enter a name please.")
    return
  if salary < 0 || salary == ""
    alert("Enter a valid salary.")
    return
  if !ssn.match(/[0-9]{9}/)
    alert("Enter a valid social security number. No hypens needed.")
  if username == ""
    alert("Enter a username.")
    return
  if p1 != p2
    alert("Passwords don't match.")
    return

  id = empArray[currentEmpIndex]["ID"]

  $.ajax
    url: "/immersion/admin/edit_employee?name=#{name}&position=#{position}" +
      "&salary=#{salary}&birth=#{birth}&id=#{id}&ssn=#{ssn}&username=#{username}" +
      if p1 != "" then "&password=#{p1}" else "" +
      if username != empArray[currentEmpIndex]["User_Name"]
      then "&did_change_username=true" else "&did_change_username=false"
    type: "POST"
    format: "json"
    success: (data) ->
      console.log data
      if data.success
        $("#overlay-employee").click()
        empArray[currentEmpIndex] = data.employee
        updateEmpTableRow(currentEmpIndex, data.employee)
      else if data.failure
        if data.failure == "t"
          alert("Failed to insert employee into database")
        else if data.failure == "username"
          alert("Username already in database.")
      $("#overlay-employee form input:last-child").prop("disabled", false)
    failure: (error) ->
      console.log "Error: #{error}"
      $("#overlay-employee form input:last-child").prop("disabled", false)

updateEmpTableRow = (index, employee) ->
  row = $("#adminpage__employees .table-row:nth-child(#{index+2})")
  row.find(".table-row-name").text employee["Name"]
  row.find(".table-row-position").html "<b>Position:</b> " + employee["Position"]
  row.find(".table-row-salary").html "<b>Salary:</b> " + employee["Pay"]
  row.find(".table-row-username").html "<b>Username:</b> " + employee["User_Name"]
  row.find(".table-row-birth").html "<b>Birth Date:</b> " + employee["Birth Date"]
  row.find(".table-row-ssn").html "<b>SSN:</b> " + employee["SSN"]
  row.find(".table-row-id").html "<b>People ID:</b>  " + employee["ID"]

# Update functions for `non-employees` table

openEditNonEmpRow = (index) ->
  isUpdating = true
  currentNonEmpIndex = index
  form = $("#overlay-non-employee form")
  form.find("#non_emp_name").val nonEmpArray[index]["Name"]
  form.find("#type").val nonEmpArray[index]["Type"]
  form.find("#join_date").val nonEmpArray[index]["join_date"]
  form.find("#donor_amount").val nonEmpArray[index]["donor_amount"]
  form.find("input:last-child").val "Update Details"
  $("#overlay-non-employee").fadeIn 200, ->
    $("#overlay-non-employee #non_emp_name").focus()

editNonEmployeeRow = (form) ->
  name = form.find("#non_emp_name").val()
  type = form.find("#type").val()
  joinDate = form.find("#join_date").val()
  donorAmount = form.find("#donor_amount").val()
  if name == ""
    alert "Person must have a valid name."
    return
  if !joinDate.match(/[0-9]{4}-[0-9]{2}-[0-9]{2}/)
    alert("Enter birth date in the form YYYY-MM-DD.")
    return
  if !donorAmount.match(/[0-9]/ig) || donorAmount < 0
    alert("Enter a valid donor amount.")
    return

  id = nonEmpArray[currentNonEmpIndex]["ID"]

  $.ajax
    url: "/immersion/admin/edit_non_employee?name=#{name}&type=#{type}" +
      "&join=#{joinDate}&donor_amount=#{donorAmount}&id=#{id}"
    type: "POST"
    format: "json"
    success: (data) ->
      console.log data
      if data.success
        $("#overlay-non-employee").click()
        nonEmpArray[currentNonEmpIndex] = data.nonEmployee
        updateNonEmpTableRow(currentNonEmpIndex, data.nonEmployee)
      else if data.failure
        alert("Failed to insert person into database")
    failure: (error) ->
      console.log "Error: #{error}"

updateNonEmpTableRow = (index, nonEmployee) ->
  row = $("#adminpage__nonemployees .table-row:nth-child(#{index+2})")
  row.find(".table-row-name").text nonEmployee["Name"]
  row.find(".table-row-type").html "<b>Type:</b> " + nonEmployee["Type"]
  row.find(".table-row-join-date").html "<b>Join Date:</b> " + nonEmployee["join_date"]

  if nonEmployee["donor_amount"] > 0
    if !(row.find(".table-row-donor").length > 0)
      donor = document.createElement "div"
      $(donor).addClass "table-row-donor"
      row.find(".table-row-col:first-child")[0].appendChild donor
    row.find(".table-row-donor").html "<b>Donor Amount: </b>$" + nonEmployee["donor_amount"]
  else if nonEmployee["donor_amount"] == 0
    if row.find(".table-row-donor").length > 0
      row.find(".table-row-donor").remove()

# Edit function for exhibits table-row-donor

openEditExhibitRow = (index) ->
  $("#overlay-exhibit form input:last-child").val "Edit Exhibit"
  isUpdating = true
  isSearchingExhibitArt = false
  currentExhibitIndex = index
  currentExhibitArt = exhibitsArray[index]["art_hash"]
  $("#modal-gallery .table-row").each (index, ele) ->
      $(this).remove()
  buildExhibitArtTable(artArray)
  form = $("#overlay-exhibit > .modal > form")
  form.find("#exhibit_title").val exhibitsArray[index]["Title"]
  form.find("#start_date").val exhibitsArray[index]["start_date"]
  form.find("#end_date").val exhibitsArray[index]["end_date"]
  form.find("#main_image").val exhibitsArray[index]["main_image"]
  form.find("#description").val exhibitsArray[index]["description"]
  $("#overlay-exhibit").fadeIn 200, ->
    $(this).find("#exhibit_title").focus()

editExhibitRow = (form) ->
  title = form.find("#exhibit_title").val()
  if title == "" || title.indexOf(":") == -1
    alert("Exhibit must have a name and a colon to separate a title and subtitle.")
    return
  start = form.find("#start_date").val()
  if !start.match(/[0-9]{4}-[0-9]{2}-[0-9]{2}/)
    alert("Enter start date in the form YYYY-MM-DD.")
    return
  end = form.find("#end_date").val()
  if !end.match(/[0-9]{4}-[0-9]{2}-[0-9]{2}/)
    alert("Enter end date in the form YYYY-MM-DD.")
    return
  mainImg = form.find("#main_image").val()
  if !mainImg.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i)
    alert("Enter main image UUID. Must match RFC4122.")
    return
  description = form.find("#description").val()

  id = exhibitsArray[currentExhibitIndex]["ID"]
  console.log id
  console.log "/immersion/admin/edit_exhibit?title=#{title}&start=#{start}&end=#{end}&main_image=#{mainImg}" +
    (if Object.keys(currentExhibitArt).length > 0 then "&data=" + JSON.stringify currentExhibitArt else "") +
    "&id=#{id}&description=#{description}"
  $.ajax
    url: "/immersion/admin/edit_exhibit?title=#{title}&start=#{start}&end=#{end}&main_image=#{mainImg}" +
      (if Object.keys(currentExhibitArt).length > 0 then "&data=" + JSON.stringify currentExhibitArt else "") +
      "&id=#{id}&description=#{description}"
    type: "POST"
    format: "json"
    success: (data) ->
      console.log data
      if data.success
        $("#overlay-exhibit").click()
        hash = {}
        data.exhibit.art.forEach (ele, index) ->
          hash[ele["UUID"]] = true
        data.exhibit["art_hash"] = hash
        exhibitsArray[currentExhibitIndex] = data.exhibit
        updateExhibitRow(currentExhibitIndex, data.exhibit)
      else if data.failure
        if data.failure == "title"
          alert("Exhibit with that title already exists.")
        else if data.failure == "main_image"
          alert("That main image does not exist in the database.")
        else
          alert("Failed to insert exhibit into database")
    failures: (err) ->
      console.log "Error requesting data"

updateExhibitRow = (index, exhibit) ->
  row = $("#adminpage__exhibits .table-row:nth-child(#{index+2})")
  row.find(".table-row-exhibit-title").text exhibit["Title"]
  row.find(".table-row-exhibit-start").html "<b>Start Date:</b> " + exhibit["start_date"]
  row.find(".table-row-exhibit-end").html "<b>End Date:</b> " + exhibit["end_date"]
  row.find(".table-row-main-image").html "<b>Main Image:</b> " + exhibit["main_image"]
