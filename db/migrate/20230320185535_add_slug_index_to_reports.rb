class AddSlugIndexToReports < ActiveRecord::Migration[6.1]
  def change
    add_index :reports, :slug, unique: true
  end
end
