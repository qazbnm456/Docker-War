require 'rails_helper'

describe PagesController, type: :controller do

  describe ':home' do
    it 'should show root page' do
      get :home
      expect(response).to be_success
    end
  end
end