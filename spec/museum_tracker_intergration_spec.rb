require('capybara/rspec')
require('./app')
require('spec_helper')
require('sinatra')
Capybara.app == Sinatra::Application
# set(:show_exceptions, false)

  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM museums *;")
      DB.exec("DELETE FROM artworks *;")
    end
  end

  describe('index landing page', {:type => :feature}) do
    it('processes the user entry') do
      visit('/')
      click_button('Museums')
      expect(page).to have_content('Museums')
      click_button('Artwork')
      expect(page).to have_content('Artwork')
    end
  end
