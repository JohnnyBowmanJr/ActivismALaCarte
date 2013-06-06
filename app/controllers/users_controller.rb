class UsersController < ApplicationController
  def mycampaigns
    @backbone = true
    @campaigns = Campaign.where("organizer_id = ?", current_user.id)
    render :mycampaigns
  end


  def my_recording
    binding.pry
    account_sid = 'AC3ecb799e792404580fe5e903b88d3929'
    auth_token = 'd5ee548232ded22642dfe296d46df3af'
    client = Twilio::REST::Client.new(account_sid, auth_token)
    @list = client.account.recordings.list()
    render :json => @list
  end

end
