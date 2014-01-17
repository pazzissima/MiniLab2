require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'pry'




get '/' do
 
  erb :index
end




post '/result' do
  search_str = params[:movie]
  response = Typhoeus.get("http://www.omdbapi.com/", :params => {:s => search_str })
  result = JSON.parse(response.body)

  @movies = result["Search"]

erb :result
end


get '/poster/:imdb' do |imdb_id|
  id = params[:imdb]
  response_ID = Typhoeus.get("http://www.omdbapi.com", :params => {:i => id})
  result_ID =JSON.parse(response_ID.body)

  @movie = movies[id]
erb :show

end

