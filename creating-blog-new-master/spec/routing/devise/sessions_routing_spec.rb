require 'rails_helper'

RSpec.describe Devise::SessionsController, type: :routing do
  describe 'routing' do
    it do
      is_expected.to route(:get, '/users/sign_in')
        .to(controller: 'devise/sessions', action: 'new')
    end
    it do
      is_expected.to route(:post, '/users/sign_in')
        .to(controller: 'devise/sessions', action: 'create')
    end
    it do
      is_expected.to route(:delete, '/users/sign_out')
        .to(controller: 'devise/sessions', action: 'destroy')
    end
  end
end
