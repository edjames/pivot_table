module Helpers

  def build_data_object(id, row, column)
    OpenStruct.new id: id, row_name: row, column_name: column
  end

end
