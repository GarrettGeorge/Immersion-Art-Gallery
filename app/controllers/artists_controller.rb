class ArtistsController < ApplicationController
  def show
    render 'artistpage'
  end
  def index
  end

  def data
    if params.has_key?(:artistFirstName) && params.has_key?(:artistLastName)
      send_artist_data(params[:artistFirstName], params[:artistLastName])
    end
  end

  def send_artist_data(first, last)
    test_data = {
      "mainImage" => {
        "url" => "de2c4a3c-c70c-4a86-9e53-02348b4efaba",
        "title" => "Number 3",
        "date" => "1949",
        "style" => "Action Painting",
        "medium" => "Enamel, Oil, Canvas"
      },
      "biography" => {
        "text" => "Deemed the “greatest painter alive” during his lifetime, Jackson Pollock was an American painter who was a major artist abstract " +
        "expressionist art in the 20th century. Pollock was expelled from two high schools during his formative years, the second one being Los Angeles " +
        "Manual Arts School, where he was encouraged to pursue his interest in art. In 1930, he moved to New York to study art, and secured a job under the " +
        "WPA Federal Art Project, a New Deal project, which allowed him to earn a living from his painting.\n\n" +
        "As he was gaining professional and social success, Pollock fought the addiction of alcoholism and recurring bouts of depression. Two of his brothers" +
        " suggested Jungian psychotherapy, with Dr. Joseph Henderson, who encouraged Pollock in his artistic endeavors as part of his therapy. Although the " +
        "psychotherapy did not cure his drinking, it did expose him to Jungian concepts, which he expressed in his paintings at the time. In 1945, Pollock moved " +
        "with his wife and American painter Lee Krasner to Springs, New York, where he would remain the rest of his life. In the barn behind the house, which he " +
        "converted to his studio, Pollock developed a new and completely novel technique of painting using what he called his “drip” technique. Using hardened " +
        "brushes, sticks, and turkey basters, and household enamel paints, Pollock squirted, splashed, and dripped his paint onto canvas rolled out over his " +
        "studio floor. In 1956, Time magazine gave Pollock the name “Jack the Dripper,” referencing his unique style of action painting.\n\n" +
        "Recent studies by art historians and scientists have determined that some of Pollock’s work display properties of mathematical fractals, " +
        "asserting that his works became more fractal-like throughout his career. In his later paintings, Pollock reduced the titles of all of his " +
        "paintings to numbers, in order to reduce the viewers attempt to indentify any representational element in his paintings. Pressured by his " +
        "growing fame and demand from art collectors, Pollock’s alcoholism worsened. In August of 1956, while driving under the influence of alcohol, " +
        "he was involved in a single–car accident, killing himself and one of his passengers. Pollock’s legacy was secured by his widow, Lee Krasner, " +
        "who managed his estate after his death. His legacy includes a number of references in social media, including songs, poems, books, and documentaries," +
        " and the feature film biopic Pollock, directed by and starring Ed Harris.",
        "birth" => "Jan 28, 1912",
        "death" => "Aug 01, 1956",
        "nationality" => "American",
        "artMovement" => "Abstract Expressionism",
        "field" => "Painting"
      }
    }
    render :json => test_data
  end
end
