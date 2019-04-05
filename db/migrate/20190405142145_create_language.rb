class CreateLanguage < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :iso_639_1
      t.string :iso_639_2t
      t.string :iso_639_2b
      t.string :description
    end
  end

end


#
# def up
#   execute <<-SQL
#     CREATE TYPE quotation_type AS ENUM ('insight', 'quote');
#     CREATE TYPE quotation_indication AS ENUM ('','avoid', 'follow');
#   SQL
#
#   add_column :quotations, :type_quote, :quotation_type
#   add_column :quotations, :indication, :quotation_indication
# end
#
# def down
#   remove_column :quotations, :type_quote
#   remove_column :quotations, :indication
#   execute <<-SQL
#     DROP TYPE quotation_type;
#     DROP TYPE quotation_indication;
#   SQL
# end
