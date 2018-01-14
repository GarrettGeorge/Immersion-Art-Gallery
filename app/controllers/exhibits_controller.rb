class ExhibitsController < ApplicationController
  def show
    render 'exhibitpage'
  end

  def data
    if params.has_key?(:exhibitName)
      puts "sending specific exhibit data"
      send_exhibit_data(params[:exhibitName])
    elsif params.has_key?(:all)
      send_all_exhibits()
    end
  end

  def send_all_exhibits
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    sql = "select * from `exhibits`"
    exhibits = client.query(sql)
    # exhibits.each do |e|
    #   sql = "select * from art where `in_exhibit` = #{ActiveRecord::Base.connection.quote(e["Title"])}"
    #   temp_results = client.query(sql)
    #   e["art"] = temp_results
    # end

    render :json => exhibits
  end

  def send_exhibit_data(name)
    test_data = {
      "mainImage" => {
        "url" => "1850cdab-081e-41e4-b858-b28f12756bf1",
        "title" => "Loplop Introduces Members of the Surrealist Group",
        "date" => "1931",
        "style" => "Surrealism",
        "medium" => "Cut-and-pasted gelatin silver prints," +
          "cut-and-pasted printed paper," +
          "pencil, and pencil frottage on paper"
      },
      "description" => {
        "text": "This exhibition surveys the career of the preeminent Dada and Surrealist " +
          "artist Max Ernst (French and American, born Germany, 1891–1976), with particular " +
          "emphasis on his ceaseless experimentation. Ernst began his pursuit of radical new " +
          "techniques that went \"beyond painting\" to articulate the irrational and unexplainable" +
          " in the wake of World War I, continuing through the advent and aftermath of World War II." +
          " Featuring approximately 100 works drawn from the Museum’s collection, the exhibition " +
          "includes paintings that challenged material and compositional conventions; collages and " +
          "overpaintings utilizing found printed reproductions; frottages (rubbings); illustrated" +
          " books and collage novels; sculptures of painted stone and bronze; and prints made using" +
          " a range of techniques. Several major, multipart projects represent key moments in Ernst’s" +
          " long career, ranging from early Dada and Surrealist portfolios of the late 1910s and " +
          "1920s to his late masterpiece—a recent acquisition to MoMA's collection—65 Maximiliana " +
          "or the Illegal Practice of Astronomy (1964). This illustrated book comprises 34 aquatints" +
          " complemented by imaginative typographic designs and a secret hieroglyphic script of " +
          "the artist’s own invention.",
        "date" => "January 1, 2018",
        "floor" => "Floor 2",
        "url" => "356ac94e-15af-47b4-8542-110309f90aa7"
      },
      "images": [
        {
          "url" => "1850cdab-081e-41e4-b858-b28f12756bf1",
          "title" => "Loplop Introduces Members of the Surrealist Group",
          "artist" => "Max Ernst",
          "date" => "1931"
        },
        {
          "url" => "356ac94e-15af-47b4-8542-110309f90aa7",
          "title" => "Moonmad",
          "artist" => "Max Ernst",
          "date" => "1944"
        },
        {
          "url" => "7a4552fd-a918-4487-b754-f553b06c43f9",
          "title" => "The Nymph Echo",
          "artist" => "Max Ernst",
          "date" => "1936"
        },
        {
          "url" => "427c8936-efdf-4892-8f35-21da59179cd4",
          "title" => "The King Playing with the Queen",
          "artist" => "Max Ernst",
          "date" => "1944"
        },
        {
          "url" => "b032d6c2-c8b2-4115-aa15-23f2684486ec",
          "title" => "An Anxious Friend",
          "artist" => "Max Ernst",
          "date" => "1944"
        },
        {
          "url" => "5349384b-abbe-4280-bc2b-07faf48883ce",
          "title" => "Wrapper from Galapagos: The Islands at the End of the World",
          "artist" => "Max Ernst",
          "date" => "1955"
        },
        {
          "url" => "4f7ae1db-260e-4982-88a7-2fbbcc24c2c7",
          "title" => "Alice in 1941",
          "artist" => "Max Ernst",
          "date" => "1941"
        },
        {
          "url" => "a5aff7d6-7397-4537-83a4-640144a1f8e9",
          "title" => "Bird-head",
          "artist" => "Max Ernst",
          "date" => "1935"
        },
        {
          "url" => "2124e72b-c346-4d66-bd82-02ace7af3035",
          "title" => "Birds Above the Forest",
          "artist" => "Max Ernst",
          "date" => "1929"
        },
        {
          "url" => "a10e8cf1-0afb-4f0b-b2ae-d33bb9245f2e",
          "title" => "Two Children Are Threatened by a Nightingale",
          "artist" => "Max Ernst",
          "date" => "1924"
        },{
          "url" => "9c553a7f-5ca8-4f79-aa38-30976fb1b168",
          "title" => "Woman, Old Man, and Flower",
          "artist" => "Max Ernst",
          "date" => "1924"
        },{
          "url" => "e9335b09-a148-42a6-8243-6d692e5dc17c",
          "title" => "The Gramineous Bicycle Garnished with Bells the Dappled Fire Damps and the Echinoderms Bending the Spine to Look for Caresses",
          "artist" => "Max Ernst",
          "date" => "1921"
        }
      ]
    }

    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    sql = "select * from `exhibits` where `Title` = #{ActiveRecord::Base.connection.quote(params[:exhibitName])}"
    exhibits = client.query(sql)
    exhibits.each do |e|
      sql = "select * from art where `in_exhibit` = #{ActiveRecord::Base.connection.quote(e["Title"])}"
      temp_results = client.query(sql)
      e["images"] = temp_results
      sql = "select * from art where `UUID` = #{ActiveRecord::Base.connection.quote(e["main_image"])}"
      main_img = client.query(sql)
      e["mainImage"] = main_img.first
    end

    render :json => exhibits.first
  end

end
