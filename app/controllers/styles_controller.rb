class StylesController < ApplicationController
  def index
  end

  def show
    render 'stylepage'
  end

  def data
    if params.has_key?(:styleName)
      send_style_data(params[:styleName])
    end
  end

  def send_style_data(name)
    test_data = {
      "mainImage" => {
        "url" => "2650aa60-36db-4f98-be47-0a6b180c18f9",
        "title" => "Untitled",
        "artist" => "Mark Rothko",
        "date" => "1945",
        "medium" => "Painting, Canvas"
      },
      "description" => {
        "text" => "Art movement of mostly non-representative painting. It flourished in US in 1940s and 1950s. Despite its name, it was neither wholly abstract " +
        "nor expressionist and comprised several quite different styles. What united them in one art movement was an intention to redefine the nature of painting.\n\n" +
        "The emergence and quick spread of Abstract Expressionism became possible due to several factors. The first one was the arrival to US of numerous modern artist " +
        "refugees from European totalitarian regimes of 1930s and war disasters of 1940s (Arshile Gorky, Hans Hofmann, George Grosz, Fernand Leger, Josef Albers, Piet" +
        " Mondrian, Marcel Duchamp, Yves Tanguy, Max Ernst). The second one was the appearance of a brand new network of NY museums and galleries that staged (for the " +
        "first time in US) major exhibitions of European modern art (MOMA was found in 1929 and gained its popularity by exposing collections of Cubism, Abstract Art, " +
        "Dada, Surrealism as well as retrospectives of Leger, Matisse and Picasso; Guggenheim Museum started its career in 1939 by a grand exhibition of Kandinsky). And " +
        "the third factor was a support of art critics (Clement Greenberg), wealthy patrons and collectors (Peggy Guggenheim, Leo Castelli), who supplied artists with " +
        "finances and positive reviews, and very promptly made this new art movement fashionable and trendy.\n\n" +
        "Abstract Expressionism originates from surpassing the Great Depression (when US suffered economically and – as opposed to Europe - was culturally isolated and " +
        "provincial) and from overcoming the collective post-war trauma. Two main American art movements of 1930s - Regionalism and Social Realism – were unapt to provide " +
        "the language for an emerging reality. It was expressed in Existentialist philosophy which rejected trust in reason, humanism, scientific and technological progress," +
        " and preached a tragic worldview, sense of loneliness and utmost attention to the inner world of the individual. This perception of reality reflected in " +
        "Abstract Expressionism – which resumed in US the trend started in Europe by Abstract Art and Surrealism. It liberated the art from laws of logics and laws of " +
        "color syntax set by European culture, and referred to religion, myth and chaos of unconscious.\n\n" +
        "Abstract Expressionism emerged in two different “versions”. The first one was Action Painting (Jackson Pollock, Willem de Kooning), where the artist used " +
        "expressive spontaneous gestures to splash paints and to draw lines. The second version was Color Field Painting (Barnett Newman, Mark Rothko), that obliged " +
        "artist to work with huge array of paints in a more calm manner. Both versions were united by monumental size of canvasses (and sculptures), by color flowing " +
        "without restraint, and by emphasis on the process (rather than on the result) of image creation.\n\n" +
        "In the early 1950s New York became the world art capital. This status was confirmed, above all, by emerging of New York School – an informal group of artists," +
        " poets, musicians and dancers who professed the principles of Abstract Expressionism. Since the mid-1950s, it became a powerful international trend, " +
        "capturing almost all continents. Art Informel, Tashisme and COBRA group may be considered as European counterparts of this art movement. By the early 1960s " +
        "Abstract Expressionism had exhausted its potential, but its themes and techniques proceeded to Op Art, Pop Art, Minimalism, Neo-Expressionism and other " +
        "art movements.\n\n",
        "artists" => [
          {
            "href" => "Jackson-Pollock",
            "name" => "Jackson Pollock"
          },
          {
            "href" => "mark-rothko",
            "name" => "Mark Rothko"
          },
          {
            "href" => "willem-kooning",
            "name" => "Willem De Kooning"
          },
          {
            "href" => "mark-tobey",
            "name" => "Mark Tobey"
          }
        ]
      },
      "images" => [
        {
          "url" => "96368d8b-f6da-4e63-a3d8-41ea147a13fa",
          "title" => "Taches with Fingerprints",
          "artist" => "Victor Hugo",
          "date" => "1865"
        },
        {
          "url" => "d23f0c6c-1cff-4472-bd0a-a1ac48fc53c3",
          "title" => "Number 20",
          "artist" => "Bradley Walker Tomlin",
          "date" => "1949"
        },
        {
          "url" => "de9c991d-136a-44ff-9b4e-bccbc611e15a",
          "title" => "Composition with Taches",
          "artist" => "Victor Hugo",
          "date" => "1875"
        },
        {
          "url" => "e3601141-c93b-4625-aa81-ce4882735169",
          "title" => "Surf and Bird",
          "artist" => "Morris Graves",
          "date" => "1940"
        },
        {
          "url" => "e5c618e2-f842-4fb3-917c-f22de3639055",
          "title" => "The Liver is in the Cock's Comb",
          "artist" => "Arshile Gorky",
          "date" => "1944"
        },
        {
          "url" => "6460c2cd-4c9d-4200-9d3c-1d49aee4d206",
          "title" => "The Parachutists",
          "artist" => "William Baziotes",
          "date" => "1944"
        },
        {
          "url" => "de2bffed-b44f-4573-9de7-74331cded7e9",
          "title" => "Seated Nude",
          "artist" => "Lee Krasner",
          "date" => "1940"
        },
        {
          "url" => "170b0220-094b-4043-9b94-ef04eaa4b1f8",
          "title" => "Rosier-feuilles",
          "artist" => "Marcel Barbeau",
          "date" => "1946"
        },
        {
          "url" => "a5fbb172-13b8-4140-8fb6-0271ff8d958e",
          "title" => "Virgin Forest",
          "artist" => "Marcel Barbeau",
          "date" => "1948"
        }
      ]
    }

    # sql = "Select * from art"
    # client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    # records_array = client.query(sql)
    # records_array.each { |r| puts r["Title"] }
    render :json => test_data
  end
end
