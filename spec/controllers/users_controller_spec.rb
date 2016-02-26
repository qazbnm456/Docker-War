require 'rails_helper'

describe UsersController, type: :controller do

  let(:user) { create :user }

  describe ':show' do
    context ':without login' do
      it 'should not show user\'s profile' do
        get :show, id: 1
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    context ':with login' do
      it 'should show user\'s profile' do
        sign_in user
        get :show, id: user.id
        expect(response).to be_success
      end
    end
  end
end