class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name, :access_token
  has_many :calls
  has_many :campaigns, :through => :calls

  # a user has many campaigns that she creates
  has_many :organized_campaigns, :class_name => 'Campaign', :foreign_key => :organizer_id
  
  #a user (aka organizer) has many users through the campaigns she creates
  has_many :users, :through => :organized_campaigns, :source => :organizer

  # currently this isn't working. Does campaign need to belong_to 
  has_many :organized_calls, :class_name => "Call", :through => :organized_campaigns, :source => :organizer

  has_many :links

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
  
    unless user
      user = User.create(provider:auth.provider, 
        uid:auth.uid, 
        email:auth.info.email, 
        password:Devise.friendly_token[0,20]
        )
    end
    user
  end

end
