require 'pp'

class LoginController < ApplicationController
  def submit
    username = ActiveRecord::Base.connection.quote(params[:user])
    password = ActiveRecord::Base.connection.quote(params[:password])
    sql = "select * from employees where User_name = #{username} and password = #{password}"
    puts sql
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    records_array = client.query(sql)
    if records_array.count == 0
      flash.now[:notice] = 'Invalid username or password combination.'
    else
      puts session.id
      update_sql = "update employees set Session_Token = #{ActiveRecord::Base.connection.quote(session.id)} where User_name = #{username}"
      puts sql
      client.query(update_sql)
      redirect_to "/immersion/admin"
    end
  end
end
