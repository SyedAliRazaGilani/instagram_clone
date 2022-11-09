require 'rails_helper'
RSpec.describe Story, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:caption) }
  end

  describe 'Active Storage' do
    subject { create(:story).image }
    it { is_expected.to be_an_instance_of(ActiveStorage::Attached::One) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
  end
end
