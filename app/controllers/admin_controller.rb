class AdminController < ApplicationController
  def index
    puts session.id
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    sql = "select * from employees where Session_Token = " +
      "#{ActiveRecord::Base.connection.quote(session.id)} order by 'Artist' asc"
     puts sql
    results = client.query(sql)
    if results.count == 0
      render 'failure'
    else
      render 'index'
    end
  end

  def data
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    sql = "select * from employees where Session_Token = #{ActiveRecord::Base.connection.quote(session.id)}"
    results = client.query(sql)
    return if results.count == 0

    puts "is legit"
    sql = "select * from art"
    art_results = client.query(sql)
    sql = "select * from employees inner join people on employees.People_ID1 = people.id"
    emp_results = client.query(sql)
    sql = "select * from `non-employees` inner join people on `non-employees`.People_ID1 = people.id"
    non_results = client.query(sql)
    sql = "select * from `exhibits`"
    exhibits = client.query(sql)
    exhibits.each do |e|
      sql = "select * from art where `in_exhibit` = #{ActiveRecord::Base.connection.quote(e["Title"])}"
      temp_results = client.query(sql)
      e["art"] = temp_results
    end
    data = {
      "art" => art_results,
      "employees" => emp_results,
      "non_employees" => non_results,
      "exhibits" => exhibits
    }

    render :json => data
  end

  def add_art
    sql = "INSERT INTO art (`Title`, `Artist`, `Year Produced`, `Style`, `Medium`, `UUID`) " +
      "VALUES (#{ActiveRecord::Base.connection.quote(params[:artwork_title])}, " +
      "#{ActiveRecord::Base.connection.quote(params[:artist])}, " +
      "#{ActiveRecord::Base.connection.quote(params[:date])}, " +
      "#{ActiveRecord::Base.connection.quote(params[:artwork_style])}, " +
      "#{ActiveRecord::Base.connection.quote(params[:medium])}, " +
      "#{ActiveRecord::Base.connection.quote(params[:uuid])})"

    puts sql
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    client.query(sql)
    sql = "select * from art where uuid = #{ActiveRecord::Base.connection.quote(params[:uuid])}"
    result = client.query(sql)
    if result.count > 0
      res =
      {
        "success" => "t",
        "art" => result.first
      }
      render :json => res
    else
      res = { "failure" => "t" }
      render :json => res
    end
  end

  def remove_art
    res = Hash.new
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    sql = "select * from art where uuid = #{ActiveRecord::Base.connection.quote(params[:uuid])}"
    check_result = client.query(sql)
    puts "check|" + check_result.first["in_exhibit"] + "|"
    if check_result.first["in_exhibit"] != ""
      res = {
        "failure" => "in_exhibit"
      }
    else
      res = {
        "success" => "in_exhibit"
      }
    end
    if res["success"] == "in_exhibit"
      sql = "delete from art where uuid = #{ActiveRecord::Base.connection.quote(params[:uuid])}"
      puts params[:uuid]
      puts sql
      client.query(sql)
      sql = "select * from art where uuid = #{ActiveRecord::Base.connection.quote(params[:uuid])}"
      result = client.query(sql)
      if result.count == 0
        res = { "success" => "t" }
      else
        res = { "failure" => "t" }
      end
    end
    render :json => res
  end

  def edit_art
    sql = "update art set " +
    "`Title` = #{ActiveRecord::Base.connection.quote(params[:artwork_title])}, " +
    "`Artist` = #{ActiveRecord::Base.connection.quote(params[:artist])}, " +
    "`Year Produced` = #{ActiveRecord::Base.connection.quote(params[:date])}, " +
    "`Style` = #{ActiveRecord::Base.connection.quote(params[:artwork_style])}, " +
    "`Medium` = #{ActiveRecord::Base.connection.quote(params[:medium])} " +
    "where `UUID` = #{ActiveRecord::Base.connection.quote(params[:uuid])}"
    puts sql
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    client.query(sql)
    sql = "select * from art where uuid = #{ActiveRecord::Base.connection.quote(params[:uuid])}"
    result = client.query(sql)
    if result.count > 0
      res =
      {
        "success" => "t",
        "art" => result.first
      }
      render :json => res
    else
      res = { "failure" => "t" }
      render :json => res
    end
  end

  def add_employee
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    sql = "select * from employees where `User_Name` = " +
      "#{ActiveRecord::Base.connection.quote(params[:username])}"
    result = client.query(sql)
    if result.count == 0
      res = {
        "success" => "t",
        "employee" => result.first
      }
      render :json => res
    else
      res = {
        "failure" => "username"
      }
    end

    sql = "insert into people (`name`) values (#{ActiveRecord::Base.connection.quote(params[:name])})"
    puts sql
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    client.query(sql)
    id = client.last_id
    sql = "INSERT INTO employees (`SSN`, `Position`, `Birth Date`, `Pay`, `People_ID1`, " +
      "`User_Name`, `password`) " +
      "VALUES (#{ActiveRecord::Base.connection.quote(params[:ssn])}, " +
      "#{ActiveRecord::Base.connection.quote(params[:position])}, " +
      "#{ActiveRecord::Base.connection.quote(params[:birth])}, " +
      "#{ActiveRecord::Base.connection.quote(params[:salary])}, " +
      "#{client.last_id}, " +
      "#{ActiveRecord::Base.connection.quote(params[:username])}, " +
      "#{ActiveRecord::Base.connection.quote(params[:password])})"
    client.query(sql)

    puts sql
    sql = "select * from employees inner join people on employees.People_ID1 = people.id " +
      "and People_ID1 = #{ActiveRecord::Base.connection.quote(id)}"
    puts sql
    result = client.query(sql)
    if result.count > 0
      res =
      {
        "success" => "t",
        "employee" => result.first
      }
      render :json => res
    else
      res = { "failure" => "t" }
      render :json => res
    end
  end

  def remove_employee
    sql = "delete from employees where People_ID1 = " +
      "#{ActiveRecord::Base.connection.quote(params[:id])}"
    puts sql
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    client.query(sql)
    sql = "delete from people where ID = " +
      "#{ActiveRecord::Base.connection.quote(params[:id])}"
    client.query(sql)
    sql = "select * from employees where People_ID1 = " +
      "#{ActiveRecord::Base.connection.quote(params[:id])}"
    result = client.query(sql)
    if result.count == 0
      res = { "success" => "t" }
      render :json => res
    else
      res = { "failure" => "t" }
      render :json => res
    end
  end

  def edit_employee
    res = Hash.new
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    if params[:did_change_username] == "true"
      sql = "select * from employees where `User_Name` = " +
        "#{ActiveRecord::Base.connection.quote(params[:username])}"
      puts sql
      result = client.query(sql)
      if result.count == 0
        res = {
          "success" => "t",
          "employee" => result.first
        }
      else
        res = {
          "failure" => "username"
        }
      end

    else
      res = {
        "success" => "t"
      }
    end

    if res["success"] == "t"
      sql = "update people set `name` = #{ActiveRecord::Base.connection.quote(params[:name])} " +
        "where `ID` = #{ActiveRecord::Base.connection.quote(params[:id])}"
      puts sql
      client.query(sql)
      sql = "update employees set `SSN` = #{ActiveRecord::Base.connection.quote(params[:ssn])}, " +
        "`Position` = #{ActiveRecord::Base.connection.quote(params[:position])}, " +
        "`Birth Date` = #{ActiveRecord::Base.connection.quote(params[:birth])}, " +
        "`Pay` = #{ActiveRecord::Base.connection.quote(params[:salary])}, " +
        "`User_Name` = #{ActiveRecord::Base.connection.quote(params[:username])}"
      if params.has_key?(:password)
        sql += ", `password` = #{ActiveRecord::Base.connection.quote(params[:password])}"
      end
      sql += " where `People_ID1` = #{ActiveRecord::Base.connection.quote(params[:id])}"
      puts sql
      client.query(sql)

      sql = "select * from employees inner join people on employees.People_ID1 = people.id " +
        "and `People_ID1` = #{ActiveRecord::Base.connection.quote(params[:id])}"
      result = client.query(sql)
      if result.count > 0
        res =
        {
          "success" => "t",
          "employee" => result.first
        }
      else
        res = { "failure" => "sql" }
      end
    end

    render :json => res
  end

  def remove_employee
    sql = "delete from employees where People_ID1 = " +
      "#{ActiveRecord::Base.connection.quote(params[:id])}"
    puts sql
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    client.query(sql)
    sql = "delete from people where ID = " +
      "#{ActiveRecord::Base.connection.quote(params[:id])}"
    client.query(sql)
    sql = "select * from employees where People_ID1 = " +
      "#{ActiveRecord::Base.connection.quote(params[:id])}"
    result = client.query(sql)
    if result.count == 0
      res = { "success" => "t" }
      render :json => res
    else
      res = { "failure" => "t" }
      render :json => res
    end
  end

  def search_employee
    if params.has_key?(:all)
      client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
      sql = "select * from employees inner join people on employees.People_ID1 = people.id"
      results = client.query(sql)
      puts sql
      render :json => results
    else
      client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
      sql = "select * from employees inner join people on employees.People_ID1 = people.id where "
      conds = []
      if params.has_key?(:name)
        conds.push("`Name` REGEXP #{ActiveRecord::Base.connection.quote(params[:name])}")
      end
      if params.has_key?(:position)
        conds.push("`Position` REGEXP #{ActiveRecord::Base.connection.quote(params[:position])}")
      end
      if params.has_key?(:salary)
        conds.push("`Pay` REGEXP #{ActiveRecord::Base.connection.quote(params[:salary])}")
      end
      if params.has_key?(:id)
        conds.push("`ID` REGEXP #{ActiveRecord::Base.connection.quote(params[:id])}")
      end
      if params.has_key?(:birthDate)
        conds.push("`Birth Date` REGEXP #{ActiveRecord::Base.connection.quote(params[:birthDate])}")
      end
      if params.has_key?(:ssn)
        conds.push("`SSN` REGEXP #{ActiveRecord::Base.connection.quote(params[:ssn])}")
      end
      sql += conds.join(" and ")
      puts sql
      results = client.query(sql)

      render :json => results
    end
  end

  def add_non_employee
    res = Hash.new

    sql = "insert into people (`name`) values (#{ActiveRecord::Base.connection.quote(params[:name])})"
    puts sql
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    client.query(sql)
    id = client.last_id
    sql = "INSERT INTO `non-employees` (`Type`, `People_ID1`, `join_date`, `donor_amount`) " +
      "VALUES (#{ActiveRecord::Base.connection.quote(params[:type])}, " +
      "#{client.last_id}, " +
      "#{ActiveRecord::Base.connection.quote(params[:join])}, " +
      "#{ActiveRecord::Base.connection.quote(params[:donor_amount])})"
    client.query(sql)

    puts sql
    sql = "select * from `non-employees` inner join people on `non-employees`.People_ID1 = people.id " +
      "and People_ID1 = #{ActiveRecord::Base.connection.quote(id)}"
    puts sql
    result = client.query(sql)
    if result.count > 0
      res =
      {
        "success" => "t",
        "nonEmployee" => result.first
      }
    else
      res = { "failure" => "t" }
    end

    render :json => res
  end

  def edit_non_employee
    res = Hash.new
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    sql = "update people set `name` = #{ActiveRecord::Base.connection.quote(params[:name])} " +
      "where `ID` = #{ActiveRecord::Base.connection.quote(params[:id])}"
    puts sql
    client.query(sql)
    sql = "update `non-employees` set `Type` = #{ActiveRecord::Base.connection.quote(params[:type])}, " +
      "`join_date` = #{ActiveRecord::Base.connection.quote(params[:join])}, " +
      "`donor_amount` = #{ActiveRecord::Base.connection.quote(params[:donor_amount])} " +
      "where `People_ID1` = #{ActiveRecord::Base.connection.quote(params[:id])}"
    puts sql
    client.query(sql)

    sql = "select * from `non-employees` inner join people on `non-employees`.People_ID1 = people.id " +
      "and `People_ID1` = #{ActiveRecord::Base.connection.quote(params[:id])}"
    result = client.query(sql)
    if result.count > 0
      res =
      {
        "success" => "t",
        "nonEmployee" => result.first
      }
    else
      res = { "failure" => "sql" }
    end
    render :json => res
  end

  def remove_non_employee
    sql = "delete from `non-employees` where People_ID1 = " +
      "#{ActiveRecord::Base.connection.quote(params[:id])}"
    puts sql
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
    client.query(sql)
    sql = "delete from people where ID = " +
      "#{ActiveRecord::Base.connection.quote(params[:id])}"
    client.query(sql)
    sql = "select * from `non-employees` where People_ID1 = " +
      "#{ActiveRecord::Base.connection.quote(params[:id])}"
    result = client.query(sql)
    res = Hash.new
    if result.count == 0
      res = { "success" => "t" }
    else
      res = { "failure" => "t" }
    end
    render :json => res
  end

  def search_non_employee
    if params.has_key?(:all)
      client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
      sql = "select * from `non-employees` inner join people on `non-employees`.People_ID1 = people.id"
      results = client.query(sql)
      puts sql
      render :json => results
    else
      client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
      sql = "select * from `non-employees` inner join people on `non-employees`.People_ID1 = people.id where "
      conds = []
      if params.has_key?(:name)
        conds.push("`Name` REGEXP #{ActiveRecord::Base.connection.quote(params[:name])}")
      end
      if params.has_key?(:type)
        conds.push("`Type` REGEXP #{ActiveRecord::Base.connection.quote(params[:type])}")
      end
      if params.has_key?(:join)
        conds.push("`join_date` REGEXP #{ActiveRecord::Base.connection.quote(params[:join])}")
      end
      if params.has_key?(:id)
        conds.push("`People_ID1` REGEXP #{ActiveRecord::Base.connection.quote(params[:id])}")
      end
      if params.has_key?(:donor_amount)
        conds.push("`donor_amount` REGEXP #{ActiveRecord::Base.connection.quote(params[:donor_amount])}")
      end
      sql += conds.join(" and ")
      puts sql
      results = client.query(sql)

      render :json => results
    end
  end

  def add_exhibit
    res = Hash.new
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")

    sql = "select * from `exhibits` where `Title` = #{ActiveRecord::Base.connection.quote(params[:title])}"
    check_results = client.query(sql)
    if check_results.count > 0
      res = {
        "failure" => "title"
      }
    else
      res = {
        "success" => "title"
      }
    end

    sql = "select * from art where `UUID` = #{ActiveRecord::Base.connection.quote(params[:main_image])}"
    uuid_check = client.query(sql)
    if uuid_check.count == 0
      res = {
        "failure" => "main_image"
      }
    else
      res = {
        "success" => "main_image"
      }
    end

    if res["success"] == "title" || res["success"] == "main_image"
      sql = "insert into exhibits (`Title`, `start_date`, `end_date`, `main_image`, `description`) " +
      "values (#{ActiveRecord::Base.connection.quote(params[:title])}, " +
      "#{ActiveRecord::Base.connection.quote(params[:start])}, " +
      "#{ActiveRecord::Base.connection.quote(params[:end])}, " +
      "#{ActiveRecord::Base.connection.quote(params[:main_image])}, " +
      "#{ActiveRecord::Base.connection.quote(params[:desc])})"
      puts sql
      client.query(sql)

      if params.has_key?(:data)
        hash = JSON.parse params[:data]
        quoted_array = hash.keys.map { |key| ActiveRecord::Base.connection.quote(key) }.join(", ")
        puts quoted_array
        sql = "update art set `in_exhibit` = #{ActiveRecord::Base.connection.quote(params[:title])} " +
        "where `UUID` in (#{quoted_array})"
        puts sql

        client.query(sql)
      end

      sql = "select * from `exhibits` where `Title` = #{ActiveRecord::Base.connection.quote(params[:title])}"
      exhibits = client.query(sql)
      exhibits.each do |e|
        sql = "select * from art where `in_exhibit` = #{ActiveRecord::Base.connection.quote(e["Title"])}"
        temp_results = client.query(sql)
        e["art"] = temp_results
      end
      if exhibits.count > 0
        res =
        {
          "success" => "t",
          "exhibit" => exhibits.first
        }
      else
        res = { "failure" => "t" }
      end
    end

    render :json => res
  end

  def edit_exhibit
    res = Hash.new
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")

    sql = "select * from `exhibits` where `Title` = #{ActiveRecord::Base.connection.quote(params[:title])}"
    check_results = client.query(sql)
    if check_results.count > 0
      res = {
        "failure" => "title"
      }
    else
      res = {
        "success" => "title"
      }
    end

    sql = "select * from art where `UUID` = #{ActiveRecord::Base.connection.quote(params[:main_image])}"
    uuid_check = client.query(sql)
    if uuid_check.count == 0
      res = {
        "failure" => "main_image"
      }
    else
      res = {
        "success" => "main_image"
      }
    end

    if res["success"] == "title" || res["success"] == "main_image"
      sql = "update exhibits set `Title` = #{ActiveRecord::Base.connection.quote(params[:title])}, " +
      "`start_date` = #{ActiveRecord::Base.connection.quote(params[:start])}, " +
      "`end_date` = #{ActiveRecord::Base.connection.quote(params[:end])}, " +
      "`main_image` = #{ActiveRecord::Base.connection.quote(params[:main_image])}, " +
      "`description` = #{ActiveRecord::Base.connection.quote(params[:description])} " +
      "where `ID` = #{ActiveRecord::Base.connection.quote(params[:id])}"
      puts sql
      client.query(sql)
      if params.has_key?(:data)
        hash = JSON.parse params[:data]
        quoted_array = hash.keys.map { |key| ActiveRecord::Base.connection.quote(key) }.join(", ")
        puts quoted_array
        sql = "update art set `in_exhibit` = #{ActiveRecord::Base.connection.quote(params[:title])} " +
        "where `UUID` in (#{quoted_array})"
        client.query(sql)

        sql = "update art set `in_exhibit` = '' where `in_exhibit` = #{ActiveRecord::Base.connection.quote(params[:title])} " +
        "AND `UUID` NOT IN (#{quoted_array})"
        puts sql
        client.query(sql)
      end

      sql = "select * from `exhibits` where `Title` = #{ActiveRecord::Base.connection.quote(params[:title])}"
      exhibits = client.query(sql)
      exhibits.each do |e|
        sql = "select * from art where `in_exhibit` = #{ActiveRecord::Base.connection.quote(e["Title"])}"
        temp_results = client.query(sql)
        e["art"] = temp_results
      end
      if exhibits.count > 0
        res =
        {
          "success" => "t",
          "exhibit" => exhibits.first
        }
      else
        res = { "failure" => "t" }
      end
    end

    render :json => res
  end

  def remove_exhibit
    res = Hash.new
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")

    sql = "delete from exhibits where `ID` = #{ActiveRecord::Base.connection.quote(params[:id])}"
    client.query(sql)
    sql = "select * from exhibits where `ID` = #{ActiveRecord::Base.connection.quote(params[:id])}"
    delete_check = client.query(sql)
    if delete_check.count == 0
      res = {
        "success" => "t"
      }
    else
      res = {
        "failure" => "t"
      }
    end

    if res["success"] == "t" && params.has_key?(:data)
      hash = JSON.parse params[:data]
      quoted_array = hash.keys.map { |key| ActiveRecord::Base.connection.quote(key) }.join(", ")
      sql = "update art set `in_exhibit` = '' " +
      "where `UUID` in (#{quoted_array})"
      client.query(sql)
    end

    render :json => res
  end

  def search_exhibit
    if params.has_key?(:all)
      client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
      sql = "select * from exhibit"
      results = client.query(sql)
      puts sql
      render :json => results
    else
      client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
      sql = "select * from employees inner join people on employees.People_ID1 = people.id where "
      conds = []
      if params.has_key?(:Title)
        conds.push("`Title` REGEXP #{ActiveRecord::Base.connection.quote(params[:tTitle])}")
      end
      if params.has_key?(:start_date)
        conds.push("`Beginning` REGEXP #{ActiveRecord::Base.connection.quote(params[:start_date])}")
      end
      if params.has_key?(:end_date)
        conds.push("`Ending` REGEXP #{ActiveRecord::Base.connection.quote(params[:end_date])}")
      end
      if params.has_key?(:main_image)
        conds.push("`Thematic Piece` REGEXP #{ActiveRecord::Base.connection.quote(params[:main_image])}")
      end
    end
    sql += conds.join(" and ")
    puts sql
    results = client.query(sql)
    render :json => results
  end

  def do_nothing

  end
end
