require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let(:user) { User.new(first_name: 'Mark', last_name: 'Twain', email: 'test@test.COM', password: 'secret123', password_confirmation: 'secret123') }
    let(:user2) { User.new(first_name: 'Henry', last_name: 'Fonda', email: 'TEST@TEST.com', password: 'password123', password_confirmation: 'password123') }


    it 'is valid when all arguments provided' do
      puts user.inspect
      expect(user).to be_valid
    end

    it 'is invalid when password is not provided' do
      user.password = nil
      expect(user).to_not be_valid
    end

    it 'is not valid when first name is not present' do
      user.first_name = nil
      expect(user).to_not be_valid
    end

    it 'is not valid when last name is not present' do
      user.last_name = nil
      expect(user).to_not be_valid
    end

    it 'is invalid when password and its confirmation differ' do
      user.password_confirmation = 'different'
      expect(user).to_not be_valid
    end

    it 'is invalid when email is already in taken' do
      user.save
      expect(user2).to_not be_valid
    end

    it 'is invalid when password is under minimum length' do
      user.password = '1234567'
      expect(user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    let(:user) { User.new(first_name: 'Mark', last_name: 'Twain', email: 'test@test.COM', password: 'secret123', password_confirmation: 'secret123') }

    it 'is logged in when the user exists' do
      user.save
      fetchedUser = User.authenticate_with_credentials('test@test.COM', 'secret123')
      expect(fetchedUser).to_not be_nil
    end

    it 'is valid when email input has extra whitespace' do
      user.save
      fetchedUser = User.authenticate_with_credentials(' test@test.com ', 'secret123')
      expect(fetchedUser).to_not be_nil
    end

    it 'is valid when characters are incorrectly capitalized' do
      user.save
      fetchedUser = User.authenticate_with_credentials('tEsT@TeSt.cOm', 'secret123')
      expect(fetchedUser).to_not be_nil
    end

    it 'is invalid when email is incorrect credential/does not exist' do
      fetchedUser = User.authenticate_with_credentials('wrong@email.com ', 'secret123')
      expect(fetchedUser).to be_nil
    end
  end
end