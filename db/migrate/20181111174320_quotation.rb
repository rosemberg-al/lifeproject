class Quotation < ActiveRecord::Migration[5.2]
  def change
    create_table :quotations do |t|
      t.references :user, foreign_key: true
      t.references :content, foreign_key: true
      t.string :quotation
      t.integer :page_initial
      t.integer :page_final
      t.integer :order
      t.datetime :inactivated_at
      t.timestamps
    end
  end
end
