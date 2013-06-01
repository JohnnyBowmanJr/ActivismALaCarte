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

  has_many :organized_campaigns, :class_name => 'Campaign', :foreign_key => :organizer_id
  #how do you say an organizer has many users through the campaigns she organizes?
  has_many :users, :through => :organized_campaigns, :source => :organizer
  

end
