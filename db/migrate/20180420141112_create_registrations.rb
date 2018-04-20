class CreateRegistrations < ActiveRecord::Migration[5.1]
  def change
    create_table :registrations do |t|
      #t.integer :camp_id
      t.references :camp, foreign_key: true
      t.references :student, foreign_key: true
      #t.integer :student_id
      t.text :payment

      t.timestamps
    end
  end
end
