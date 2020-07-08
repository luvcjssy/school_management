class Test < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :answers, :through => :questions
  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
  validate :at_least_one_question

  def at_least_one_question
    errors.add(:test, "must has at least one Question") if questions.length.zero?
  end
end
