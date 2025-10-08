# Hotel API

A REST API service for searching hotels through integration with the BoomNow external service.

> 📖 **Getting Started**: See [instructions.md](instructions.md) for installation, running, and testing instructions.

## About the Project

Hotel API is a Rails application that provides a simple interface for searching hotels by city and number of adult guests. The application integrates with the BoomNow Open API to retrieve current hotel data.

### How it works

1. The API receives a search request with city and number of guests
2. Authenticates with BoomNow API using OAuth credentials
3. Fetches hotel listings from the external service
4. Returns formatted results as JSON

### Key Features

- **Simple REST API** - Single endpoint for hotel search
- **External API Integration** - Connects to BoomNow Open API
- **Error Handling** - Validates parameters and handles API errors gracefully
- **CORS Support** - Configured for cross-origin requests
- **Health Check** - Built-in endpoint for monitoring
- **Docker Ready** - Includes Dockerfile for containerization

## Tech Stack

- **Ruby** 3.1.2
- **Rails** 7.2.2
- **PostgreSQL** - Database
- **HTTParty** - HTTP client for external API integration
- **Puma** - Web server
- **Docker** - Container support
- **Rack CORS** - Cross-origin resource sharing support

## Project Structure

```
app/
├── controllers/
│   └── hotels_controller.rb    # HTTP request handler
├── services/
│   └── hotels/
│       └── search.rb            # Business logic for BoomNow API integration
config/
├── routes.rb                    # API routes definition
└── initializers/
    └── cors.rb                  # CORS configuration
```

## API Endpoints

### Hotel Search
- **Endpoint**: `GET /hotels/search`
- **Parameters**: 
  - `city` (required) - City name
  - `number_of_adults` (required) - Number of adult guests
- **Returns**: Array of hotel objects or error message

### Health Check
- **Endpoint**: `GET /up`
- **Returns**: 200 if application is running, 500 otherwise

## BoomNow API Integration

The service acts as a proxy to the BoomNow Open API:

1. **Authentication**: Obtains access token via `/open_api/v1/auth/token`
2. **Hotel Search**: Queries listings via `/open_api/v1/listings`

API credentials are currently stored in `app/services/hotels/search.rb` (should be moved to environment variables for production).

## Development

The project includes tools for development:

- **Testing**: Minitest framework
- **Linting**: RuboCop for code style
- **Security**: Brakeman for vulnerability scanning
- **Debugging**: Pry and Pry-Rails

## Security Considerations

⚠️ **Important for Production:**

- Move `CLIENT_ID` and `CLIENT_SECRET` to environment variables
- Configure `config/credentials.yml.enc` for secrets management
- Restrict CORS to specific allowed origins
- Implement rate limiting to prevent abuse
- Use HTTPS for all external API communication

## Logging

All errors during external API interactions are logged via `Rails.logger`. Development logs are available in `log/development.log`.

## License

[Specify your project license]

## Contact

[Specify contact information]
