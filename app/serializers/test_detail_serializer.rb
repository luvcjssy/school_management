class TestDetailSerializer < ActiveModel::Serializer
  attributes *(Test.column_names.map { |k| k.to_sym })
  has_many :questions, serializer: QuestionSerializer
end
