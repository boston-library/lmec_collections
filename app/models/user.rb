class User < ApplicationRecord
  has_many :galleries, -> { order(:created_at) }

  before_create :create_default_gallery

  include Blacklight::User

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/ }

  def default_gallery
    galleries.find(&:default?)
  end

  protected

  def create_default_gallery
    galleries.build(name: Gallery.default_name, user: self)
  end

  self.string_display_key ||= :email
end
