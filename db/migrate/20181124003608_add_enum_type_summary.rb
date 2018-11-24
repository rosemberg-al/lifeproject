class AddEnumTypeSummary < ActiveRecord::Migration[5.2]


  #desabilitando a transação para conseguir rodar o alter type
  #i'm desabling the transaction to be able to run the alter type
 disable_ddl_transaction!

  def up
    execute <<-SQL
      ALTER TYPE content_summary_type ADD VALUE 'script'  AFTER  'text' ;
    SQL

    execute <<-SQL
      ALTER TYPE content_summary_type ADD VALUE 'tutorial'  AFTER  'script' ;
    SQL
  end
end
