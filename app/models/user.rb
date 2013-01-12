class User < ActiveRecord::Base
  include UsersHelper
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  translates :first_name, :last_name

  has_many :authentications, :dependent => :destroy
  has_many :brands

  def apply_omniauth(omniauth)
    I18n.available_locales.each do |locale|
      write_attribute(:first_name, omniauth[:info][:locale][locale][:first_name], :locale => locale)
      write_attribute(:last_name, omniauth[:info][:locale][locale][:last_name], :locale => locale)
    end
    self.email = omniauth["info"]["email"] if email.blank?
    self.image_url = omniauth["info"]["image"]
    authentications.build(:provider => omniauth["provider"], :uid => omniauth["uid"])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def self.from_omniauth(auth)
    Authentication.where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def name
    full_name(first_name, last_name)
  end
end
