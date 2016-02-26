require 'rails_helper'

describe Identity, type: :model do
  let(:callback) { User }
  let(:data) { { :provider => 'facebook', :uid => '10', :info => { :email => 'email@example.com', :name => 'why' }, :extra => { :raw_info => { :email => 'email@example.com', :id => '10', :name => 'why' } } } }

  describe 'find_for_oauth_data' do
    it 'should respond to :find_for_oauth' do
      expect(callback).to respond_to(:find_for_oauth)
    end

    it 'should create a new user' do
      expect(callback.find_for_oauth(data)).to be_a(User)
    end

    it 'should handle provider facebook properly' do
      result = callback.find_for_oauth(data)
      expect(result.email).to eq('email@example.com')
    end

    it 'should generate some random password' do
      expect(callback.find_for_oauth(data).password).not_to be_blank
    end

    it 'should set user sex' do
      expect(callback.find_for_oauth(data).sex_id).to eq(1)
    end

    it 'should set user major' do
      expect(callback.find_for_oauth(data).major_id).to eq(11)
    end

    it 'should set user score' do
      expect(callback.find_for_oauth(data).score).to eq(0)
    end
  end
end