class AddIndexFeatureToContentType < ActiveRecord::Migration[5.1]
  def change
    add_index :content_types, :feature
  end
end
