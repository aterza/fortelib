class CreatePrimeForms < ActiveRecord::Migration
  def change
    create_table :prime_forms do |t|
      t.integer :cardinal
			t.integer :ordinal
			t.string  :sequence
      t.timestamps null: false
    end
  end
end
