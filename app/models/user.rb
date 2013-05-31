class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :campaigns
  has_many :callers, :through => :campaigns
  
  has_many :calls, :source => :caller
  has_many :participated_campaigns, :through => :calls, :class_name => 'Campaign'
  

end
