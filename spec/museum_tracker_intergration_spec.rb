require("rspec")
require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
# set(:show_exceptions, false)

  RSpec.configure do |config|
    config.include Capybara::DSL
    config.after(:each) do
      DB.exec("DELETE FROM museums *;")
      DB.exec("DELETE FROM artworks *;")
    end
  end

  describe('Home', {:type => :feature}) do
    it('displays expected home page content') do
      visit('/')
      page.should have_content("Art Tracker Dashboard")
    end
  end


  describe('fill in name field in form and reach museum page', {:type => :feature}) do
    it('processes the user entry') do
      visit('/')
      fill_in('name', with:'Smithsonian')
      click_button('Add')
      expect(page).to have_content('Museums')
    end
  end

  describe('fill in location field in form and reach museum page', {:type => :feature}) do
    it('processes the user entry') do
      visit('/')
      fill_in('location', with:'Washington')
      click_button('Add')
      expect(page).to have_content('Museums')
    end
  end
