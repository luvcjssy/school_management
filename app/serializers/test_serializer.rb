class TestSerializer < ActiveModel::Serializer
  attributes *(Test.column_names.map { |k| k.to_sym })
end
