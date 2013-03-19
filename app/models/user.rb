class User < ActiveRecord::Base
  # Relations
  has_many :identities

  def contents
    Content.joins(identity: :user)
           .where("users.id = ?", id)
           .order("created_at DESC")
  end

end
