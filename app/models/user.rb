class User < ApplicationRecord
  has_many :galleries, -> { order(:created_at) }

  before_create :create_default_gallery

  # Connects this user object to Blacklights Bookmarks.
  include Blacklight::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :cas_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Used for registration, but not sign-on
  include Devise::Models::DatabaseAuthenticatable

  # Configuration added by Blacklight; Blacklight::User uses a method key on your
  # user class to get a user-displayable login/identifier for
  # the account.

  def default_gallery
    galleries.find(&:default?)
  end

  protected

  def create_default_gallery
    galleries.build(name: Gallery.default_name, user: self)
  end

  def cas_extra_attributes=(extra_attributes)
    extra_attributes.each do |name, value|
      case name.to_sym
      when :last_name
        self.last_name = value
      when :first_name
        self.first_name = value
      when :display_name
        self.display_name = value
      when :email
        self.email = value
      when :staff
        self.staff = value
      end
    end
  end

  self.string_display_key ||= :email
end
