class Admin::DashboardController < Admin::BaseController
  def show
    @productCount = Product.count
    @categoryCount = Category.count
  end
end
