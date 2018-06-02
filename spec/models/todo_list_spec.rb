require 'rails_helper'

RSpec.describe TodoList, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:list_items).dependent(:destroy) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:user) }
  end
end
