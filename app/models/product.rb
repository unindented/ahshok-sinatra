module Ahshok
  class Product

    include DataMapper::Resource

    property :id,           Serial
    property :asin,         String, length:  10, unique_index: true
    property :title,        String, length: 255
    property :author,       String, length: 255
    property :link,         URI
    property :small_image,  URI
    property :medium_image, URI
    property :large_image,  URI

    validates_presence_of :asin, :title, :link

  end
end
