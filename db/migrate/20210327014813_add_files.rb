class AddFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :analyzed_files do |t|
      t.references :report
      t.string :name
      t.decimal :skunk_score, precision: 8, scale: 2
      t.decimal :churn_times_cost, precision: 8, scale: 2
      t.decimal :churn, precision: 8, scale: 2
      t.decimal :cost, precision: 8, scale: 2
      t.decimal :coverage, precision: 8, scale: 2
      t.timestamps
    end
  end
end
