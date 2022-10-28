# GET /albums Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL) - None
  * or body parameters (passed in the request body) - None

  Method: GET
  path: /albums

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```
Doolittle
Surfer Rosa
OK Computer
```

return title and release_year fields for all album records embedded in HTML

## 3. Write Examples

_Replace these with your own design._

```
# Request:

GET /albums

Expected response:

200 OK

Looop through each album in the table displlaying Title & Release YEar





```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /albums" do
    it "returns the title and release year for all albums" do
      response = get('/albums')
      expected_response = '<div>
      Title: Doolittle
      Released: 1989
    </div>'
      
      expect(response.status).to eq 200
      expect(response.body).to include expected_response
    end
  end

    it "should return links for each the albums" do
      response = get('/albums')

      expect(response.status).to eq 200
      expect(response.body).to include <a href="/albums/2">Surfer Rosa</a>
      expect(response.body).to include <a href="/albums/3">Waterloo</a>
      expect(response.body).to include <a href="/albums/4">Super Trouper</a>
      expect(response.body).to include <a href="/albums/4">Bossanova</a>
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->
