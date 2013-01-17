class User < ActiveRecord::Base
  include UsersHelper

  attr_accessible :email
  translates :first_name, :last_name

  has_many :brands
  has_many :layout_templates

  validates :email, :presence => true, :uniqueness => true, :email_format => true

  def self.from_omniauth(auth)
    where(:nuvo_uid => auth.uid).first_or_initialize.tap do |user|
      user.nuvo_uid = auth.uid
      user.email = auth.info["email"]
      user.image_url = auth.info["image"]
      I18n.available_locales.each do |locale|
        user.write_attribute(:first_name, auth.info["locale"][locale][:first_name], :locale => locale)
        user.write_attribute(:last_name, auth.info["locale"][locale][:last_name], :locale => locale)
      end
      user.nuvo_access_token = auth.credentials.token
      user.nuvo_access_token_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
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

  def nuvo
    @nuvo ||= Nuvo::API.new(nuvo_access_token)
  end
end
