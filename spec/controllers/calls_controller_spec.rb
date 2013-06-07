require 'spec_helper'

describe CallsController do

  before do
    params = {"AccountSid"=>"AC3ecb799e792404580fe5e903b88d3929",
     "ApplicationSid"=>"APc47ff3822652f09502959b08335d24a7",
     "Caller"=>"client:johnny",
     "CallStatus"=>"completed",
     "Duration"=>"1",
     "Called"=>"",
     "To"=>"",
     "CallDuration"=>"20",
     "CallSid"=>"CA8d2f5d4c42986b27da60ffe1846a8c9b",
     "From"=>"client:johnny",
     "Direction"=>"inbound",
     "ApiVersion"=>"2010-04-01",
     "action"=>"callback",
     "controller"=>"campaigns"}
  end
  
  it "should make a successful POST request to campaigns/callback" do
    #enter code here to make a post request make sure new call is persisted
  end
  

end
