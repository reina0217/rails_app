require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validates' do
    it 'name' do
      is_expected.to validate_presence_of(:name)
      is_expected.to validate_length_of(:name).is_at_most(255)
      is_expected.to validate_uniqueness_of(:name)
    end
  end
end
