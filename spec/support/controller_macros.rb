module ControllerMacros

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.make!
      binding.pry
      sign_in user
    end
  end
end