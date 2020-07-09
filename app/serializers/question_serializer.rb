class QuestionSerializer < ActiveModel::Serializer
  attributes *(Question.column_names.map { |k| k.to_sym }), :answers
end