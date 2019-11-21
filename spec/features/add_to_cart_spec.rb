require 'rails_helper'

RSpec.feature "user can click add to cart button for a product on home page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'They see the cart updated by one' do
    # ACTION
    visit root_path
    my_button = page.all('form .fa.fa-shopping-cart').first
    
    my_button.click

    # DEBUG / VERIFY
    
    expect(page).to have_content 'My Cart (1)'
    puts page.html
    save_screenshot

  end
end