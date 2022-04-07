class CreateTfas < ActiveRecord::Migration[6.1]
  def change
    create_table :tfa_tfas do |t|
      t.integer :code
      t.string :phone
      t.string :after
      t.boolean :used

      t.timestamps
    end
  end
end
