class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.datetime :create_date
      t.integer :number
      t.string :act_type
      t.text :item_desc
      t.string :value_when_done
      t.string :where_to_do
      t.string :short_task_name
      t.string :swiss_cheese
      t.boolean :out_indicator

      t.timestamps
    end
  end
end
