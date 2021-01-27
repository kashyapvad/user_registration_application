class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged
  has_secure_password
  has_one :link_hash, dependent: :destroy
  validates :username, length: {minimum: 5}, on: :update
  validates :password, length: {minimum: 8}
  validates :email, presence: true, uniqueness: true, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :message => "address not valid"}

  after_save :purge_fastly

  def set_username
    self.email = self.email.downcase
    self.username = self.email.split('@').first
  end

  def purge_fastly
    self.purge
  end
end
