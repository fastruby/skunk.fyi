class AddProjects < ActiveRecord::Migration[6.1]
  def up
    create_table :projects do |t|
      t.string :git_url
      t.string :permalink
      t.string :name
      t.timestamps
    end

    add_reference :reports, :project, foreign_key: true
    add_index :projects, :permalink, unique: true
  end

  def down
    remove_reference :reports, :project, foreign_key: true

    drop_table :projects
  end
end
