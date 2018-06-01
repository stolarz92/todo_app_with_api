require 'rails_helper'

RSpec.describe ListItem, type: :model do
  let(:list_item) { create(:list_item) }

  describe 'relationships' do
    it { is_expected.to belong_to(:todo_list) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'attributes' do
    it 'complete is initially nil' do
      expect(list_item.completed).to be_nil
    end
  end

  describe 'instance methods' do
    describe '#toggle_complete' do
      it 'set item completed' do
        list_item.toggle_complete
        expect(list_item.completed).to be_kind_of(Time)
      end

      it 'set item completed to nil' do
        list_item.update_attribute(:completed, Time.now)
        list_item.toggle_complete
        expect(list_item.completed).to be_nil
      end
    end
  end
end
