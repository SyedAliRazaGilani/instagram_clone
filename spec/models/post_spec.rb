require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Active Storage' do
    subject { create(:post).images }
    it { is_expected.to be_an_instance_of(ActiveStorage::Attached::Many) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end
end
