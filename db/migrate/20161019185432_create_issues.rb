class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title
      t.integer  :volume
      t.integer :issue_number
      t.date :date

      t.timestamps null: false
    end
  end
end
