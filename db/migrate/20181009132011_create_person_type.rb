class CreatePersonType < ActiveRecord::Migration[5.1]

    def up
      execute <<-SQL
        CREATE TYPE person_type AS ENUM ('real', 'fictional');
      SQL
    end

    def down
      execute <<-SQL
        DROP TYPE person_type;
      SQL
    end
end
