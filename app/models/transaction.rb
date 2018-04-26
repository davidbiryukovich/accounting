class Transaction < ApplicationRecord

  belongs_to :category
  validates :date, presence: true
  validates :amount, presence: true
end