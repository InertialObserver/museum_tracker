class Artwork
  attr_reader(:id, :name, :artist, :museum_id)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @artist = attributes.fetch(:artist)
    @museum_id = attributes.fetch(:museum_id)
  end

  define_singleton_method(:all) do
    artwork_list = DB.exec("SELECT * FROM artworks;")
    artworks = []
    artwork_list.each() do |artwork|
      id = artwork.fetch("id").to_i
      name = artwork.fetch("name")
      artist = artwork.fetch("artist")
      museum_id = artwork.fetch("museum_id").to_i
      artworks.push(Artwork.new({:id => id, :name => name, :artist => artist, :museum_id => museum_id}))
    end
    artworks
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO artworks (name, artist, museum_id) VALUES ('#{@name}', '#{@artist}', #{@museum_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i
  end

  define_method(:==) do |artwork|
    self.name().==(artwork.name()).&(self.id().==(artwork.id()))
  end

define_method(:update) do |attributes|
    @id = self.id()
    @name = attributes.fetch(:name)
    @artist = attributes.fetch(:artist)
    @museum_id = attributes.fetch(:museum_id)
    DB.exec("UPDATE artworks SET name = '#{@name}' WHERE id = #{@id}")
    DB.exec("UPDATE artworks SET artist = '#{@artist}' WHERE id = #{@id}")
    DB.exec("UPDATE artworks SET museum_id = #{@museum_id} WHERE id = #{@museum_id}")
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM artworks WHERE id = #{id};")
    name = result.first.fetch("name")
    artist = result.first.fetch("artist")
    museum_id = result.first.fetch("museum_id").to_i
    id = result.first.fetch("id").to_i
    Artwork.new({:name => name, :artist => artist, :id => id, :museum_id => museum_id})
  end

  define_method(:delete) do
    @id = self.id()
    DB.exec("DELETE FROM artworks WHERE id = #{@id}")
  end
end
