class AddLanguageToContent < ActiveRecord::Migration[5.2]
  def change
    add_reference :contents, :language, index: true
  end
end
