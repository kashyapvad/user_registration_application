class LinkHash < ApplicationRecord
  belongs_to :user
  LINK_EXPIRE_TIME = 6

  # checks if the magic link is expired or not.
  def expired?
    return self.updated_at <= (Time.now - LINK_EXPIRE_TIME.hours)
  end
end
