class TestSerializer < ActiveModel::Serializer
  attributes *(Test.column_names.map { |k| k.to_sym })
  attributes :question_count

  def question_count
    object.questions.length
  end
end
