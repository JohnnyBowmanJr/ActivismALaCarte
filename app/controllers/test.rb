class Test
	require 'twilio-ruby'
	
	def self.make_call
	  client = Twilio::REST::Client.new 'AC3ecb799e792404580fe5e903b88d3929', 'd5ee548232ded22642dfe296d46df3af'
	      
	  outbound_call = client.account.calls.create(
	    :from => '3108041305',   # From your Twilio number
	    :to => '+16176062109',     # To any number
	    # Fetch instructions from this URL when the call connects
	    :url => 'http://3emc.localtunnel.com/campaigns/voice_test/',
	    :headers => {'X-CSRF-Token' => session["_csrf_token"]},
	    :record => 'false',
	    :status_callback => 'http://3emc.localtunnel.com/campaigns/callback/',
	    :status_callback_method => 'POST'
	  )
	  puts "make call function done"
	end

	Test.make_call
end

