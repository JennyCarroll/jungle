require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    # validation examples here
    it 'each user can be saved' do
      user = User.create(first_name: "Jenny", last_name: "Carroll", email: "jennygc@telus.net", password: "testtest", password_confirmation: "testtest")
      expect(user).to be_persisted
    end

    it 'each password and password_confirmation must match' do
      user = User.create(first_name: "Jenny", last_name: "Carroll", email: "jennygc@telus.net", password: "testrest", password_confirmation: "testtest")
      expect(user).not_to be_persisted
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'password must be present' do
      user = User.create(first_name: "Jenny", last_name: "Carroll", email: "jennygc@telus.net", password: nil, password_confirmation: "testtest")
      expect(user).not_to be_persisted
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'password_confirmation must be present' do
      user = User.create(first_name: "Jenny", last_name: "Carroll", email: "jennygc@telus.net", password: "testtest", password_confirmation: nil)
      expect(user).not_to be_persisted
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'Each password has minimum length' do
      user = User.create(first_name: "Jenny", last_name: "Carroll", email: "jennygc@telus.net", password: "test", password_confirmation: "testtest")
      expect(user).not_to be_persisted
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

    it 'email must be unique and not case sensitive' do 
      user = User.create(first_name: "Jenny", last_name: "Carroll", email: "jennygc@telus.net", password: "testtest", password_confirmation: "testtest")
      user2 = User.create(first_name: "Ariel", last_name: "Carroll", email: "jennyGc@telus.net", password: "testtest", password_confirmation: "testtest")
      expect(user2).not_to be_persisted
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'Each user has an email' do
      user = User.create(first_name: "Jenny", last_name: "Carroll", email: nil, password: "testtest", password_confirmation: nil)
      expect(user).not_to be_persisted
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'Each user has a first name' do
      user = User.create(first_name: nil, last_name: "Carroll", email: "jennygc@telus.net", password: "testtest", password_confirmation: nil)
      expect(user).not_to be_persisted
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'Each user has a last name' do
      user = User.create(first_name: "Jenny", last_name: nil, email: "jennygc@telus.net", password: "testtest", password_confirmation: nil)
      expect(user).not_to be_persisted
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

  end

  describe '.authenticate_with_credentials' do
    it 'should return nil when email is correct, but password is incorrect' do
      email = " jennygc@telus.net "
      password = "testest"
      user = User.create(first_name: "Jenny", last_name: "Carroll", email: " jennygc@telus.net ", password: "testtest", password_confirmation: "testtest")
      expect(User.authenticate_with_credentials(email, password)).to eq(nil)
    end

    it 'should return nil when email is not in database' do
      email = "ariel@gmail.com"
      password = "testest"
      expect(User.authenticate_with_credentials(email, password)).to eq(nil)
    end

    it 'should return user when email has whitespace and password is correct' do
      email = " jennygc@telus.net "
      password = "testtest"
      user = User.create(first_name: "Jenny", last_name: "Carroll", email: "jennygc@telus.net", password: "testtest", password_confirmation: "testtest")
      expect(User.authenticate_with_credentials(email, password)).to eq(user)
    end

    it 'should return user when email has wrong case and password is correct' do
      email = " jenNYgc@telus.net "
      password = "testtest"
      user = User.create(first_name: "Jenny", last_name: "Carroll", email: "jennygc@telus.net", password: "testtest", password_confirmation: "testtest")
      expect(User.authenticate_with_credentials(email, password)).to eq(user)
    end
  end

end
