require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'Each Product can be saved succesfully' do
      newCategory = Category.create(name: "dice")
      product = Product.create(name: "Jenny", price: 5, quantity: 2, category_id: newCategory.id)
      expect(product).to be_persisted
    end

    it 'Each Product has a name' do
      newCategory = Category.create(name: "dice")
      product = Product.create(name: nil, price: 5, quantity: 2, category_id: newCategory.id)
      expect(product).not_to be_persisted
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'Each Product has a price' do
      newCategory = Category.create(name: "dice")
      product = Product.create(name: "Jenny", price: false, quantity: 2, category_id: newCategory.id)
      expect(product).not_to be_persisted
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'Each Product has a quantity' do
      newCategory = Category.create(name: "dice")
      product = Product.create(name: "Jenny", price: 5, quantity: nil, category_id: newCategory.id)
      expect(product).not_to be_persisted
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'Each Product has a category' do
      newCategory = Category.create(name: "dice")
      product = Product.create(name: "Jenny", price: 5, quantity: 2, category_id: nil)
      expect(product).not_to be_persisted
      expect(product.errors.full_messages).to include("Category must exist")
    end

  end
end
