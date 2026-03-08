require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validates' do
    it 'title' do
      is_expected.to validate_presence_of(:title)
      is_expected.to validate_length_of(:title).is_at_most(255)
    end

    it 'text' do
      is_expected.to validate_presence_of(:text)
      is_expected.to validate_length_of(:text).is_at_most(10000)
    end
  end
end
