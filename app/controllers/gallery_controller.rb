require "map.rb"
require 'pp'

class GalleryController < ApplicationController

  def show

  end

  def data
    images = [
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
      },
      {
        "url" => "9c553a7f-5ca8-4f79-aa38-30976fb1b168",
        "title" => "Woman, Old Man, and Flower",
        "artist" => "Max Ernst",
        "date" => "1924"
      },
      {
        "url" => "e9335b09-a148-42a6-8243-6d692e5dc17c",
        "title" => "The Gramineous Bicycle Garnished with Bells the Dappled Fire Damps and the Echinoderms Bending the Spine to Look for Caresses",
        "artist" => "Max Ernst",
        "date" => "1921"
      },
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
    #render :json => images
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    sql = "select * from art"
    results = client.query(sql)
    puts sql
    render :json => results
  end

  def map
    respond_to do |format|
      format.json {
        @map = getMap()
        render :json => @map
      }
    end
  end

end

def getMap
  MapGenerator.new(20).map
end
