class CreateTypeContentPerson < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE TYPE content_person_type AS ENUM ('author', 'director','writer','actor','speaker');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE content_person_type;
    SQL
  end
end
