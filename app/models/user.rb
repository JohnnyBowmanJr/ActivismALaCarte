class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name
  # attr_accessible :title, :body

  # has_many :campaigns
  # has_many :callers, :through => :campaigns
  
  # has_many :calls, :source => :caller
  # has_many :called_campaigns, :through => :calls, :class_name => 'Campaign'

  has_many :calls
  has_many :campaigns, :through => :calls

  # a user has many campaigns that she creates
  has_many :organized_campaigns, :class_name => 'Campaign', :foreign_key => :organizer_id
  
  #a user (aka organizer) has many users through the campaigns she creates
  has_many :users, :through => :organized_campaigns, :source => :organizer

  # currently this isn't working. Does campaign need to belong_to 
  has_many :organized_calls, :class_name => "Call", :through => :organized_campaigns, :source => :organizer
  

end
