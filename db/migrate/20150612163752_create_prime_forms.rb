class CreatePrimeForms < ActiveRecord::Migration
  def change
    create_table :prime_forms do |t|
      t.integer :cardinal, null: false
      t.string  :ordinal, null: false
      t.string  :sequence, unique: true, null: false
      t.string  :vector, null: false
      t.integer :distinct_forms, null: false, default: 24
      t.timestamps null: false
    end
  end
end
