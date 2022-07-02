class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.integer :visitor_id
      t.integer :visited_id
      t.integer :post_id
      t.integer :comment_id
      t.string :action, default: ''
      t.boolean :checked, default: false
      t.timestamps
    end
  end
end
