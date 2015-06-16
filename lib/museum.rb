class Museum
  attr_reader(:id, :name, :location)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @location = attributes.fetch(:location)
  end

  define_singleton_method(:all) do
    museum_museum = DB.exec("SELECT * FROM museums;")
    museums = []
    museum_museum.each() do |museum|
      id = museum.fetch("id").to_i
      name = museum.fetch("name")
      location = museum.fetch("location")
      museums.push(Museum.new({:id => id, :name => name, :location => location}))
    end
    museums
  end

  define_singleton_method(:find) do |id|
    found_museums = nil
    Museum.all().each do |museum|
      if museum.id().==(id)
        found_museums = museum
      end
    end
    found_museums
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO museums (name, location) VALUES ('#{@name}', '#{@location}') RETURNING id;")
    @id = result.first().fetch('id').to_i
  end

    define_method(:==) do |museum|
    self.name().==(museum.name()).&(self.id().==(museum.id()))
  end

  define_method(:delete) do
    @id = self.id()
    DB.exec("DELETE FROM museums WHERE id = #{@id};")
  end

  define_method(:update) do |attributes|
    @id = self.id()
    @name = attributes.fetch(:name)
    @location = attributes.fetch(:location)
    DB.exec("UPDATE museums SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE museums SET location = '#{@location}' WHERE id = #{@id};")
  end

  def all_artworks
    all_artworks = DB.exec("SELECT * FROM artworks WHERE museum_id = #{self.id};")
    artworks = []
    all_artworks.each {|artwork|
        name = artwork.fetch("name")
        artist = artwork.fetch("artist")
        museum_id = artwork.fetch("museum_id").to_i
        id = artwork.fetch("id").to_i
        artworks.push(Artwork.new({:name => name, :artist => artist, :museum_id => museum_id, :id => id}))
        }
        artworks
    end
end
