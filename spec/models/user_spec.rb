require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:todo_lists).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
  end
end
