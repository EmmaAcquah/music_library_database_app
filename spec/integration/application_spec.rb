require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it "returns the list of albums" do
      response = get('/albums')
      expected_title = 'Title: Surfer Rosa'
      expected_year = 'Released: 1988'
      
      expect(response.status).to eq 200
      expect(response.body).to include expected_title
      expect(response.body).to include expected_year
    end
  

  it "should return links for each the albums" do
    response = get('/albums')

    expect(response.status).to eq 200
    expect(response.body).to include('<a href="/albums/2">Surfer Rosa</a>')
    expect(response.body).to include('<a href="/albums/3">Waterloo</a>')
    expect(response.body).to include('<a href="/albums/4">Super Trouper</a>')
    expect(response.body).to include('<a href="/albums/5">Bossanova</a>')
  end

end

  context "GET /album/:id" do
    it "returns the album with id 1" do
        response = get('/albums/1')

        expect(response.status).to eq 200
        expect(response.body).to include 'Doolittle'
        expect(response.body).to include 'Released: 1989'

    end
  end

  context "POST /albums" do
    it "creates a new album record" do
        response = post('/albums', title: 'Voyage', release_year: '2022', artist_id: '5')
        expect(response.status).to eq 200
        expect(response.body).to eq ''

        response_get = get('/albums')
        expect(response_get.status).to eq 200
        expect(response_get.body).to include 'Voyage'
    end
  end

  context "GET /artists" do
    it "returns all the artists" do
        response = get('/artists')

        expect(response.status).to eq 200
        expect(response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone"
    end
    
  end

  context "GET /artists/:id" do
    it "returns a 200 response and details for a single artist" do
      response = get("/artists/2")
      
      expect(response.status).to eq 200
      expect(response.body).to include("Artist: ABBA")
      #expect(response.body).to include("Genre: Pop")
    end
  end
  

  context "POST /artists" do
  it 'adds a new artist and genre' do
    response = post('/artists', name:'Wild nothing', genre: 'Indie')
    response_get = get('/artists')


    expect(response.status).to eq(200)
    expect(response_get.body).to include('Wild nothing')
    end
  end
end


# # Request:
# POST /artists

# # With body parameters:
# name=Wild nothing
# genre=Indie

# # Expected response (200 OK)
# (No content)

# # Then subsequent request:
# GET /artists

# # Expected response (200 OK)
# Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing