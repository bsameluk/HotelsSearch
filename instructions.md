# Instructions

Step-by-step guide for installing, running, and testing the Hotel API.

## Prerequisites

Before you begin, ensure you have the following installed:

- Ruby 3.1.2
- Rails 7.2.2
- PostgreSQL
- Bundler

**OR**

- Docker (if using containerized approach)

## Installation

### 1. Clone the repository

```bash
git clone <repository-url>
cd hotel-api
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Setup the database

```bash
rails db:create
rails db:migrate
```

## Running the Application

### Option 1: Local Server

Start the Rails server:

```bash
rails server
```

The API will be available at: **http://localhost:3000**

### Option 2: Using Docker

Build the Docker image:

```bash
docker build -t hotel-api .
```

Run the container:

```bash
docker run -p 3000:3000 hotel-api
```

The API will be available at: **http://localhost:3000**

## Testing the API

### Primary Endpoint

**GET** `/hotels/search`

**Required Parameters:**
- `city` - City name (string)
- `number_of_adults` - Number of adult guests (integer)

### Example Requests

#### Using cURL

**Search hotels in Moscow:**
```bash
curl "http://localhost:3000/hotels/search?city=Moscow&number_of_adults=2"
```

**Search hotels in Paris:**
```bash
curl "http://localhost:3000/hotels/search?city=Paris&number_of_adults=4"
```

**Search hotels in London:**
```bash
curl "http://localhost:3000/hotels/search?city=London&number_of_adults=1"
```

#### Using Browser

Simply open in your browser:
```
http://localhost:3000/hotels/search?city=London&number_of_adults=2
```

### Expected Responses

#### Success Response (200 OK)

```json
[
  {
    "id": "123",
    "name": "Grand Hotel",
    "city": "Moscow",
    "address": "123 Main Street",
    "price": "150.00"
  },
  {
    "id": "456",
    "name": "City Center Hotel",
    "city": "Moscow",
    "address": "456 Center Avenue",
    "price": "200.00"
  }
]
```

#### Error Response (422 Unprocessable Entity)

**Missing city parameter:**
```json
{
  "error": "City is required"
}
```

**Missing number_of_adults parameter:**
```json
{
  "error": "Number of adults is required"
}
```

### Testing Error Handling

**Test missing city:**
```bash
curl "http://localhost:3000/hotels/search?number_of_adults=2"
```
Expected: `{"error":"City is required"}` with status 422

**Test missing number_of_adults:**
```bash
curl "http://localhost:3000/hotels/search?city=Moscow"
```
Expected: `{"error":"Number of adults is required"}` with status 422

### Health Check Endpoint

Verify the application is running:

```bash
curl http://localhost:3000/up
```

Expected: Status 200 if application is healthy

## Running Tests

Execute the test suite:

```bash
rails test
```

Run specific test file:

```bash
rails test test/controllers/hotels_controller_test.rb
```

## Code Quality Tools

### Run RuboCop (Linter)

Check code style:
```bash
bundle exec rubocop
```

Auto-fix issues:
```bash
bundle exec rubocop -a
```

### Run Brakeman (Security Scanner)

Check for security vulnerabilities:
```bash
bundle exec brakeman
```

## Debugging

The project includes `pry` and `pry-rails` for debugging.

Add a breakpoint in your code:
```ruby
binding.pry
```

Then run your code and interact with the debugger in the console.

## Viewing Logs

Development logs are written to:
```
log/development.log
```

Tail logs in real-time:
```bash
tail -f log/development.log
```

## Stopping the Application

### Local Server

Press `Ctrl + C` in the terminal where the server is running.

### Docker Container

```bash
docker stop hotel-api
```

Remove container:
```bash
docker rm hotel-api
```

## Troubleshooting

### Database connection errors

Ensure PostgreSQL is running:
```bash
# macOS with Homebrew
brew services start postgresql

# Linux with systemd
sudo systemctl start postgresql
```

### Port already in use

If port 3000 is already in use, start Rails on a different port:
```bash
rails server -p 3001
```

### Bundle install fails

Try updating bundler:
```bash
gem update bundler
bundle install
```

## Next Steps

- Review the [README.md](README.md) for project architecture and API details
- Check `config/routes.rb` for available routes
- Explore `app/services/hotels/search.rb` for API integration logic
- Review `app/controllers/hotels_controller.rb` for request handling

## Support

For issues or questions, please refer to the project's issue tracker or contact the maintainers.
