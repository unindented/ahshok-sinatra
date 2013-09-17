module Ahshok
  module Extensions
    module ProductHelper

      # Groups to be included in the Amazon response.
      LOOKUP_GROUPS = %w(Small Images)

      # Map of XPath expressions we want to extract from the Amazon response.
      LOOKUP_XPATHS = {
        asin:         '//Item/ASIN',
        title:        '//Item/ItemAttributes/Title',
        author:       '//Item/ItemAttributes/Author',
        link:         '//Item/DetailPageURL',
        small_image:  '//Item/SmallImage/URL',
        medium_image: '//Item/MediumImage/URL',
        large_image:  '//Item/LargeImage/URL'
      }

      # Search the database for the first (and only) product with the specified
      # ASIN. If it's not found, look it up in Amazon and create a new entry
      # with the returned attributes.
      def find_or_create_product(asin)
        Product.first(asin: asin) || Product.create(lookup_product(asin))
      end

      # Look up the product with the specified ASIN in Amazon, and return its
      # attributes.
      def lookup_product(asin)
        logger.info "Looking up product #{asin}..."

        # Look the product up in Amazon.
        response = settings.vacuum.get(query: {
          'Operation'     => 'ItemLookup',
          'IdType'        => 'ASIN',
          'ItemId'        => asin,
          'ResponseGroup' => LOOKUP_GROUPS.join(',')
        })
        # Parse the XML and remove all those pesky namespaces.
        xml = Nokogiri::XML(response.body)
        xml.remove_namespaces!
        # Extract the attributes we need from the response.
        LOOKUP_XPATHS.merge(LOOKUP_XPATHS) do |key, value|
          node = xml.xpath(value)
          node.map(&:text).join(', ') unless node.empty?
        end
      end

    end
  end
end
