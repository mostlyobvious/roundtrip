class CreateRoundtripTickets < ActiveRecord::Migration
  def change
    create_table :roundtrip_tickets do |t|
      t.string :summary, :null => false, :limit => 200
      t.string :state, :null => false
      t.integer :reporter_id, :references => :users, :null => false

      t.timestamps :null => false
    end
    add_index :roundtrip_tickets, :reporter_id
  end
end
