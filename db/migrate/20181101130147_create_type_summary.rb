class CreateTypeSummary < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE TYPE content_summary_type AS ENUM ('summary', 'annotation','article','report','text');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE content_summary_type;
    SQL
  end
end
