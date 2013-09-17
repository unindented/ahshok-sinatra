require File.expand_path('../spec_helper', __FILE__)

include Rack::Test::Methods

def app
  Ahshok::App
end

describe Ahshok::App do

  before do
    DataMapper.auto_migrate!
  end

  describe 'with a never-before-seen product' do

    let(:asin) { '0135974445' }

    it 'does not find the product in the database' do
      Ahshok::Product.first(asin: asin).must_be_nil
    end

    describe 'when requesting its corresponding URL' do

      before do
        VCR.use_cassette :product do
          get "/#{asin}"
        end
      end

      it 'stores the product in the database' do
        Ahshok::Product.first(asin: asin).wont_be_nil
      end

      it 'redirects to the product page' do
        last_response.must_be :redirect?
      end

      it 'redirects to a URL that contains the product ASIN' do
        last_response.location.must_include asin
      end

      it 'redirects to a URL that contains the associate tag' do
        last_response.location.must_include ENV['AMAZON_TAG']
      end

    end

  end

  describe 'with an already-seen product' do

    let(:asin) { '0135974445' }

    before do
      Ahshok::Product.create(
        asin:   asin,
        title:  'Agile Software Development',
        author: 'Robert C. Martin',
        link:   "http://www.amazon.com/dp/#{asin}/?tag=#{ENV['AMAZON_TAG']}"
      )
    end

    it 'finds the product in the database' do
      Ahshok::Product.first(asin: asin).wont_be_nil
    end

    describe 'when requesting its corresponding URL' do

      before do
        VCR.use_cassette :product  do
          get "/#{asin}"
        end
      end

      it 'redirects to the product page' do
        last_response.must_be :redirect?
      end

      it 'redirects to a URL that contains the product ASIN' do
        last_response.location.must_include asin
      end

      it 'redirects to a URL that contains the associate tag' do
        last_response.location.must_include ENV['AMAZON_TAG']
      end
    end

  end

end
