require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'before_action' do
    it { is_expected.to use_before_action(:configure_permitted_parameters) }
  end
end
