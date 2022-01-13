class CreateChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :choices do |t|
      t.string :mark
      t.integer :position

      t.timestamps
    end
  end
end
