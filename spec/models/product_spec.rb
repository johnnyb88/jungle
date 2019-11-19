require 'rails_helper'

RSpec.describe Product, type: :model do
 describe 'Validations' do
  let(:category) {Category.new(:name => 'Food')}
  # category = Category.new(:name => 'Food')
  let(:product) {Product.new(:name => 'Burger', :price_cents => 5500, :quantity => 6, :category => category)}
  # subject {Product.new(:name => 'Burger', :price => 5500, :quantity => 6, :category => category)}

  it"product is valid when containing all fields" do
    expect(product).to be_valid
  end

  it "is not valid without a name" do
    product.name = nil
    expect(product).not_to be_valid
  end

  it "is not valid without a price" do
    product.price_cents = nil
    expect(product).not_to be_valid
  end

  it "is not valid without a quantity" do
    product.quantity = nil
    expect(product).not_to be_valid
  end

  it "is not valid without a category" do
    product.category = nil
    expect(product).not_to be_valid
  end


 end
end