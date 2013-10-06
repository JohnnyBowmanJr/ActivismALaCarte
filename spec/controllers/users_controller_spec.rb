require 'spec_helper'

describe UsersController do

  it 'should tell you if the user is logged in or not' do
    get 'is_logged_in'
    expect(response.body).to eq('not logged in')
    expect(response.body).to be(success)
  end
end
