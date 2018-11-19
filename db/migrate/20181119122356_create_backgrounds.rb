class CreateBackgrounds < ActiveRecord::Migration[5.2]
  def change
    create_table :backgrounds do |t|
      t.boolean :active

      t.timestamps
    end
  end
end
