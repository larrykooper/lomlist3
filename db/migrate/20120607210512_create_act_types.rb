class CreateActTypes < ActiveRecord::Migration
  def change
    create_table :act_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
