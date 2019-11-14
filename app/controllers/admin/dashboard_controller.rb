class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["HTTP_BASIC_USER"], password: ENV["HTTP_BASIC_PASSWORD"]
  def show
    @number_of_products = Product.all.count
    @number_of_categories = Category.all.count
  end
end
