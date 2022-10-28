require "spec_helper"
require "rack/test"
require_relative '../../app'

def reset_albums_table
  seed_sql = File.read('spec/seeds/albums_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_albums_table
  end

  before(:each) do 
    reset_artists_table
  end

  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }


  context "GET /artists" do
    it "returns the list of all artists" do
      response = get('/artists')
      artist_list = 'Pixies, ABBA, Taylor Swift, Nina Simone'
      
      expect(response.status).to eq 200
      expect(response.body).to include artist_list

    end

  end

  context "GET /albums" do
    # it "returns the list of albums" do
    #   response = get('/albums')
    #   album_list = 'Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'
      
    #   expect(response.status).to eq 200
    #   expect(response.body).to include album_list

    # end
    #changed initial GET /albums test to relect that the albums page should return a list of links

    it 'returns a page with a link to each album page' do
      response = get('albums')

      expect(response.status).to eq 200
      expect(response.body).to include('Title: <a href="/albums/2">Surfer Rosa</a>')
      expect(response.body).to include('Title: <a href="/albums/3">Waterloo</a>')
      expect(response.body).to include('Title: <a href="/albums/7">Folklore</a>')
      expect(response.body).to include('Title: <a href="/albums/11">Fodder on My Wings</a>')
    end

  end

  context "POST /artists" do
    it "creates a new artist" do
      response = post('/artists', name: 'Daft Punk', genre: 'Electronic')

      expect(response.status).to eq 200
      expect(response.body).to eq ''
      #you can't test the response body of a post request directly for the new record because it doesn't return anything
      #get method test added below to check for the record added by the post request

      response_get = get('/artists')
      expect(response_get.status).to eq 200
      expect(response_get.body).to include 'Daft Punk'
    end
  end

  context "POST /albums" do
    it "creates a new album" do
        response = post('/albums', title: 'Voyage', release_year: '2022', artist_id: '2')

        expect(response.status).to eq 200
        expect(response.body).to eq ''
        #you can't test the response body of a post request directly for the new record because it doesn't return anything
        #get method test added below to check for the record added by the post request

        response_get = get('/albums')
        expect(response_get.status).to eq 200
        expect(response_get.body).to include 'Voyage'
    end

    it "creates a new album" do
      response = post('/albums', title: 'Discovery', release_year: '2001', artist_id: '7')

      expect(response.status).to eq 200
      expect(response.body).to eq ''
      #you can't test the response body of a post request directly for the new record because it doesn't return anything
      #get method test added below to check for the record added by the post request

      response_get = get('/albums')
      expect(response_get.status).to eq 200
      expect(response_get.body).to include 'Discovery'
    end
  end

  context "GET to /" do
    it 'contains a h1 title' do
      response = get('/')
  
      expect(response.body).to include('<h1>Welcome to my page</h1>')
    end
  end

  context "GET /album/:id" do
    it "returns the album with id 1" do
      response = get('/album/1')

      expect(response.status).to eq 200
      expect(response.body).to include '<h1>Doolittle</h1>'
      expect(response.body).to include 'Released: 1989'
      expect(response.body).to include 'Artist: Pixies'
    end
  end

  context "GET /artist/:id" do
    it "returns the artist with id 2" do
      response = get('/artist/2')

      expect(response.status).to eq 200
      expect(response.body).to include '<h1>ABBA</h1>'
      expect(response.body).to include 'Genre: Pop'
    end
  end

end
