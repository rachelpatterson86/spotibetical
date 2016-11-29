module ControllerMacros
  def login_voter
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.create(email: 'voting@test.com', password: 'password1')
      sign_in user
    end
  end
end
