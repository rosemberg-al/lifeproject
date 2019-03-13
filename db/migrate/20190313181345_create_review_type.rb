class CreateReviewType < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE TYPE review_type AS ENUM ('negative', 'neutral','positive');
    SQL
  end


  def down
    execute <<-SQL
      DROP TYPE review_type;
    SQL
  end
end
