class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  attr_accessible :email, :password, :password_confirmation, :remember_me, 
  :provider, :uid, :name, :access_token, :zipcode
  
  has_many :calls
  has_many :campaigns, :through => :calls

  # a user has many campaigns that she creates
  has_many :organized_campaigns, :class_name => 'Campaign', :foreign_key => :organizer_id
  
  # a user (aka organizer) has many users through the campaigns she creates
  has_many :users, :through => :organized_campaigns, :source => :organizer

  has_many :shared_links, :class_name => 'Sharelink', :foreign_key => :referrer_id
  
  has_many :referrals, :foreign_key => :clicker_id
  has_many :referred_links, :class_name => 'Sharelink', :through => :referrals, :source => :clicker


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
