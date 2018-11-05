class ChangeMovieTimeInContent < ActiveRecord::Migration[5.2]
  def change
    #change_column :contents, :movie_time, 'integer USING CAST(movie_time AS integer)'
    remove_column :contents, :movie_time
    add_column :contents, :movie_time, :integer
  end
end
