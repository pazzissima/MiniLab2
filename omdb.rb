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
  if @movies
  	erb :result
  else
  	"No movies found."
  end
end



get '/poster/:imdb' do |imdb_id|
  id = params[:imdb]
  response = Typhoeus.get("http://www.omdbapi.com", :params => {:i => id}) # retrieve data from OMDB service endpoint
  result =JSON.parse(response.body) # convert the response body (JSON-formatted) into a Ruby object

  @poster = result["Poster"]
  
erb :show

end
