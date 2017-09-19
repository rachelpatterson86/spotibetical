require 'rails_helper'

RSpec.describe UsersController do
  describe 'GET spotify' do
    subject { get :spotify }

    it { is_expected.to redirect_to('/') }
  end
end
