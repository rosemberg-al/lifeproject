class AddFeatureToContentType < ActiveRecord::Migration[5.1]
  #def change
  #end

  def up
    execute <<-SQL
      CREATE TYPE content_type_features AS ENUM ('printed', 'audiovisual', 'song','play');
    SQL
    add_column :content_types, :feature, :content_type_features
  end

  def down
    remove_column :content_types, :feature
    execute <<-SQL
      DROP TYPE content_type_features;
    SQL
  end
end
