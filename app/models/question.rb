class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :all_blank

  validates :label, presence: true
  validate :at_least_one_answer
  validate :at_least_one_correct_answer

  def at_least_one_answer
    errors.add(:_, "must has at least one Option") if answers.length.zero?
  end

  def at_least_one_correct_answer
    errors.add(:_, "must has at least one correct Option") unless answers.collect(&:correct).any?
  end
end
