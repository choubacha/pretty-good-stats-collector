class CreateInitialTables < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.text :name, null: false
      t.integer :unit, null: false, default: 0
      t.timestamps null: false
    end

    create_table :measurements do |t|
      t.integer :metric_id
      t.float :min
      t.float :max
      t.float :avg
      t.float :median
      t.float :ninety_five
      t.float :ninety_nine
      t.integer :count
      t.float :sum
      t.integer :epoch_minute

      t.index [:metric_id, :epoch_minute], unique: true
    end
  end
end
