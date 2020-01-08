
require('sinatra')
require('sinatra/reloader')
require('./lib/city')
require('./lib/train')
require('pry')
require("pg")

also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "train_system"})

get ('/') do
  @train = Train.all
  erb(:home)
end

get ('/home') do
  @train = Train.all
  erb(:home)
end

#This shows the operator page
get ('/home/operator') do
  @trains = Train.all
  @cities = City.all
  erb(:operator)
end

#this adds all the trains and cities for the operator view

post ('/home/operator') do
  if params[:train_name]
      name = params[:train_name]
      train = Train.new({:name => name, :train_id => nil})
      train.save()
      @trains = Train.all()
      @cities = City.all()
    erb(:operator)
  elsif params[:city_name]
    name = params[:city_name]
    city = City.new({:name => name, :city_id => nil})
    city.save()
    @cities = City.all()
    @trains = Train.all()

  erb(:operator)
  end
end

#this shows the page allowing the operator to add a new train


get('/train/new') do
  erb(:new_train)
end

#this shows the page allowing the operator to add a new city
get('/city/new') do
  erb(:new_city)
end

#this shows the rider view
get ('/home/rider') do
  erb(:rider)
end

#this shows the page on the operator view for a specific train id

get ('/home/operator/trains/:train_id')do
  @train = Train.find(params[:train_id].to_i())

  erb(:train)

end



#this shows the page on the operator view for a specific city id

get ('/home/operator/cities/:city_id')do

  @city = City.find(params[:city_id].to_i())

  erb(:city)


end
