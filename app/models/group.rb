class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :messages

  validates :name, presence: true, length: {maximum: 30}
  validate :minimum_user

  private
    def minimum_user
      errors.add(:users, "は1人以上必要です") if users.size < 1
    end
end
