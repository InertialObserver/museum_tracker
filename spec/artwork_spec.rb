require("spec_helper")

DB = PG.connect({:dbname => 'museum_tracker_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM artworks *;")
  end
end

describe(Artwork) do

  describe('#initialize', '#attr_reader') do
    it("returns the attributes of artwork") do
      test_artwork = Artwork.new({id: nil, name: "Mona Lisa", artist: "Leonardo da Vinci", museum_id: nil})
      expect(test_artwork.name).to(eq("Mona Lisa"))
      expect(test_artwork.artist).to(eq("Leonardo da Vinci"))
    end
  end

  describe('.all') do
    it("returns all of the artwork entered, and an empty array if there are none") do
      expect(Artwork.all).to(eq([]))
    end
  end

  describe('#save') do
    it('will save artwork to the database') do
      test_artwork = Artwork.new({:id => nil, :name => "David", :artist => "Michaelangelo", :museum_id => 1})
      test_artwork.save()
      expect(Artwork.all()).to(eq([test_artwork]))
    end
  end

  describe('#delete') do
    it('will delete artwork information') do
      test_artwork = Artwork.new({:name => "The Thinker", :id => nil, :artist => "Auguste Rodin", :museum_id => 2})
      test_artwork.save()
      test_artwork.delete()
      expect(Artwork.all()).to(eq([]))
    end
  end

  describe('#update') do
    it('will update artwork') do
      test_artwork = Artwork.new({:name => "The Persistance of Memory", :id => nil, :artist => "Salvador Dali", :museum_id => 3})
      test_artwork.save()
      test_artwork.update({:name => "Nighthawks", :artist => "Edward Hopper", :id => nil, :museum_id => 3})
      expect(test_artwork.name()).to(eq('Nighthawks'))
     end
   end

   describe(".find") do
     it("returns artwork by its id") do
       test_artwork = Artwork.new({:name => "Ripleys Believe It or Not", :id => nil, :artist => nil, :museum_id => 4})
       test_artwork.save()
       test_artwork2 = Artwork.new({:name => "The Freakybuttrue Peculiarium and Museum", :id => nil, :artist => nil, :museum_id => 4})
       test_artwork2.save()
       expect(Artwork.find(test_artwork2.id())).to(eq(test_artwork2))
     end
   end
end
