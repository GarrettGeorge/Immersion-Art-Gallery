class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end

module ApplicationHelper
  def title(text)
    content_for :title, text
  end

  def is_logged_in?
    client = Mysql2::Client.new(
      :host => "localhost",
      :username => "root",
      :database => "mydb"
    )
    sql = "select * from employees where Session_Token =" +
      " #{ActiveRecord::Base.connection.quote(session.id)}"
    results = client.query(sql)
    results.count > 0
  end
end
