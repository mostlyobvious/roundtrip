class CreateRoundtripComments < ActiveRecord::Migration
  def change
    create_table :roundtrip_comments do |t|
      t.integer :author_id, :references => :users, :null => false
      t.text :description, :null => false
      t.integer :ticket_id, :null => false, :references => :roundtrip_tickets

      t.timestamps :null => false
    end
    add_index :roundtrip_comments, :author_id
    add_index :roundtrip_comments, :ticket_id
  end
end
