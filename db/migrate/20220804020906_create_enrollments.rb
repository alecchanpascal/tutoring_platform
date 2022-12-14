class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.references :student, index: true, foreign_key: {to_table: :users}
      t.references :lesson, index: true, foreign_key: true
      t.boolean :is_accepted, default: false
      t.timestamps
    end
  end
end
