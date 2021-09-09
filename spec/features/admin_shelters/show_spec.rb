require 'rails_helper'

RSpec.describe 'the shelters show' do
  before(:each) do
    @shelter_1 = Shelter.create(
      name: 'Aurora shelter',
      city: 'Aurora, CO',
      foster_program: false,
      rank: 9)
    @shelter_2 = Shelter.create(
      name: 'RGV animal shelter',
      city: 'Harlingen, TX',
      foster_program: false,
      rank: 5
    )
    @shelter_3 = Shelter.create(
      name: 'Fancy pets of Colorado',
      city: 'Denver, CO',
      foster_program: true,
      rank: 10
    )
    @app = Application.create!(
      name: 'Oz',
      street_address: '3504 Gloria Ave.',
      city: 'Chicago',
      state: 'IL',
      zip_code: '80206',
      status: 'Pending',
      description: 'Im great'
    )
    @app.pets << @shelter_1.pets.create(
      name: 'Mr. Pirate',
      breed: 'tuxedo shorthair',
      age: 5,
      adoptable: true
    )
    @shelter_1.pets.create(
      name: 'Clawdia',
      breed: 'shorthair',
      age: 3,
      adoptable: true
    )
    @app_2 = Application.create!(
      name: 'Joe',
      street_address: '7773 Ruth Ave.',
      city: 'Bull',
      state: 'NY',
      zip_code: '80206',
      status: 'Pending'
    )
    @app_3 = Application.create!(
      name: 'Joe',
      street_address: '7773 Ruth Ave.',
      city: 'Bull',
      state: 'NY',
      zip_code: '80206',
      status: 'In Process',
      description: 'cool dude'
    )
    @app_3.pets << @shelter_2.pets.create(
      name: 'Puppy',
      breed: 'shorthair',
      age: 3,
      adoptable: true
    )
  end

  describe 'Admin Shelter Show Page' do
    xit 'lists each pet there is a botton to accept' do
      visit "/admin/shelters/#{@app}"

      aurora = @shelter_1.name
      rgv = @shelter_2.name
      fancy = @shelter_3.name

      expect(rgv).to appear_before(fancy)
      expect(fancy).to appear_before(aurora)
    end

    describe 'Shelters with Pending Applications' do
      xit 'contains section with list of shelters w/pending applications' do
        visit '/admin/shelters'

        within('#pending_apps') do
          expect(page).to have_content("Shelter's with Pending Applications")
          expect(page).to have_content(@shelter_1.name)
          expect(page).not_to have_content(@shelter_3.name)
          expect(page).not_to have_content(@shelter_2.name)
        end
      end
    end
  end
end
