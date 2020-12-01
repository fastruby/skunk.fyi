class AddSlugToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :slug, :string
  end
end