require("spec_helper")

DB = PG.connect({:dbname => 'museum_tracker_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM museums *;")
  end
end

describe(Museum) do

  describe('#initialize', '#attr_reader') do
    it("returns the attributes of museum") do
      test_museum = Museum.new({id: nil, name: "Tate Modern", location: "London, UK"})
      expect(test_museum.name).to(eq("Tate Modern"))
      expect(test_museum.location).to(eq("London, UK"))
    end
  end

  describe('.all') do
    it("returns all of the museums saved in the database, and an empty array if there are none") do
      expect(Museum.all).to(eq([]))
    end
  end

  describe('#save') do
    it('ads a museum to the array of saved museums') do
      test_museum = Museum.new({:name => "Smithsonion", :id => nil, :location => "Washington"})
      test_museum.save()
      expect(Museum.all()).to(eq([test_museum]))
    end
  end

  describe('#delete') do
    it('will delete museum information') do
      test_museum = Museum.new({:name => "Museo del Prado", :id => nil, :location => "Madrid, Spain"})
      test_museum.save()
      test_museum.delete()
      expect(Museum.all()).to(eq([]))
    end
  end

  describe('#update') do
    it('will update museum') do
      test_museum = Museum.new({:name => "Currywurst Museum", :id => nil, :location => "Berlin, Germany"})
      test_museum.save()
      test_museum.update({:name => "Cancun Underwater Museum", :location => "Cancun, Mexico", :id => nil})
      expect(test_museum.name()).to(eq('Cancun Underwater Museum'))
    end
  end

  describe(".find") do
    it("returns a museum by its id") do
      test_museum = Museum.new({:name => "Ripleys Believe It or Not", :id => nil, :location => nil})
      test_museum.save()
      test_museum2 = Museum.new({:name => "The Freakybuttrue Peculiarium and Museum", :id => nil, :location => nil})
      test_museum2.save()
      expect(Museum.find(test_museum2.id())).to(eq(test_museum2))
    end
  end

  describe('#all_artworks') do
    it('finds all the artwork in a museum') do
      test_museum = Museum.new({:name => "The Mutter Museum", :location => "Philadelphia, Penn", :id => nil})
        test_museum.save
      test_museum2 = Museum.new({:name => "British Lawnmower Museum", :location => "Lancashire, UK", :id => nil})
        test_museum2.save
      test_artwork = Artwork.new({:name => "Fossilized Fecal Matter", :artist => "Mother Nature", :id => nil, :museum_id => test_museum.id})
        test_artwork.save
      test_artwork2 = Artwork.new({:name => "Allen Scythe", :artist => "Vickers Aviation", :id => nil, :museum_id => test_museum.id})
        test_artwork2.save
        # binding.pry

      expect(test_museum.all_artworks).to(eq([test_artwork, test_artwork2]))
    end
  end

end
