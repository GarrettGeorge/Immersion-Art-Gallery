class ImmersionController < ApplicationController
  skip_before_action  :verify_authenticity_token

  def logout
    sql = "update employees set Session_Token = '000000000000'" +
      " where Session_Token = #{ActiveRecord::Base.connection.quote(session.id)}"
    puts sql
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    client.query(sql)
    sql = "select * from employees where Session_Token = #{ActiveRecord::Base.connection.quote(session.id)}"
    puts sql
    res = client.query(sql)
    if res.count > 0
      render :json => { "failure" => "t" }
    else
      render :json => { "success" => "t"}
    end
  end
end
