class Answer < ApplicationRecord
  belongs_to :question

  validates :result, presence: true
end
