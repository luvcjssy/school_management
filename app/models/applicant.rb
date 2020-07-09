class Applicant < ApplicationRecord
  belongs_to :user
  belongs_to :test

  validate :question_not_including
  validate :answer_not_including

  private

  def question_not_including
    return unless test

    question_ids = test.question_ids
    submitted_question_ids = result.map { |a| a['question_id'] }

    errors.add(:applicant, 'has questions not belong to this test') if (submitted_question_ids - question_ids).present?
  end

  def answer_not_including
    return unless test

    result.each do |r|
      answer_ids = test.answers.where(question_id: r['question_id'], id: r['answer_ids']).ids

      return errors.add(:applicant, 'has answers not belong to this test') unless answer_ids.present?
    end
  end
end
