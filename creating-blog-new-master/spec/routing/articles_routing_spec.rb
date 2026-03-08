require 'rails_helper'

RSpec.describe ArticlesController, type: :routing do
  describe 'routing' do
    it { is_expected.to route(:get, '/').to(controller: 'articles', action: 'index') }
  end
end
