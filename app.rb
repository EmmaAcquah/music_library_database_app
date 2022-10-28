# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all

    # response = @albums.map do |album|
    #   album.title
    # end.join(', ')
    # commented out the initial loop because it's been embedded in the erb view file instead

    return erb(:albums_list)
  end

  get '/album/:id' do
    repo = AlbumRepository.new
    artist_repo = ArtistRepository.new

    @album = repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)
    #make @album an instance variable so it's value can be made dynamic within an erb file
    return erb(:album) #the parenteses (not square brackets!) contain the name of the erb file containing the HTML to return
  end

  post '/albums' do
    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]

    repo.create(new_album)
  end

  get '/artists' do
    repo = ArtistRepository.new
    artists = repo.all

    response = artists.map do |artist|
      artist.name
    end.join(', ')
  end

  get '/artist/:id' do
    repo = ArtistRepository.new

    @artist = repo.find(params[:id])
    #make @album an instance variable so it's value can be made dynamic within an erb file
    return erb(:artist) #the square brackets contain the name of the erb file containing the HTML to return
  end

  post '/artists' do
    repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:name]

    repo.create(new_artist)
  end

  get '/' do
    # The erb method takes the view file name (as a Ruby symbol)
    # and reads its content so it can be sent 
    # in the response.
    return erb(:index)
  end

end