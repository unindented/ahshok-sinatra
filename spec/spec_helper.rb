# Parse the `config.ru` file to load dependencies.
require File.expand_path('../../config/builder', __FILE__)
Builder::parse_test File.expand_path('../../config.ru', __FILE__)

# Configure VCR.
VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/fixtures/cassettes'

  c.default_cassette_options = {
    serialize_with: :json,
    decode_compressed_response: true,

    match_requests_on: [
      :method,
      VCR.request_matchers.uri_without_params(:Signature, :Timestamp)
    ]
  }
end
