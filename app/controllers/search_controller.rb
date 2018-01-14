class SearchController < ApplicationController
  def input
    if params.has_key?(:all)
      client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
      sql = "select * from art"
      results = client.query(sql)
      puts sql
      render :json => results
    else
      client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "mydb")
      sql = "select * from art where "
      conds = []
      if params.has_key?(:title)
        conds.push("`Title` REGEXP #{ActiveRecord::Base.connection.quote(params[:title])}")
      end
      if params.has_key?(:artist)
        conds.push("`Artist` REGEXP #{ActiveRecord::Base.connection.quote(params[:artist])}")
      end
      if params.has_key?(:date)
        conds.push("`Year Produced` REGEXP #{ActiveRecord::Base.connection.quote(params[:date])}")
      end
      if params.has_key?(:style)
        conds.push("`Style` REGEXP #{ActiveRecord::Base.connection.quote(params[:style])}")
      end
      if params.has_key?(:medium)
        conds.push("`Medium` REGEXP #{ActiveRecord::Base.connection.quote(params[:medium])}")
      end
      if params.has_key?(:uuid)
        conds.push("`UUID` REGEXP #{ActiveRecord::Base.connection.quote(params[:uui])}")
      end
      sql += conds.join(" and ")
      puts sql
      results = client.query(sql)
      results.each do |p|
        pp p
      end

      render :json => results
    end
  end

  def do_nothing
  end
end
