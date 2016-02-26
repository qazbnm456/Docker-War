require 'rails_helper'
require 'cancan/matchers'

describe Ability, type: :model do

  context 'Admin manage all' do
    subject { Ability.new(create :admin) }

    it { is_expected.to be_able_to(:read, :all) }
    it { is_expected.to be_able_to(:access, :rails_admin) }
    it { is_expected.to be_able_to(:manage, :all) }
    it { is_expected.to be_able_to(:access, :dashboard) }
  end

  context 'Normal user can\'t manage all' do
    subject { Ability.new(create :user) }

    it { is_expected.to be_able_to(:read, :all) }
    it { is_expected.not_to be_able_to(:access, :rails_admin) }
    it { is_expected.not_to be_able_to(:manage, :all) }
    it { is_expected.not_to be_able_to(:access, :dashboard) }
  end
end