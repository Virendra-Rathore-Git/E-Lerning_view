class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :course_name
      t.string :course_desc
      t.references :teacher
      t.references :category
      t.string :status


      t.timestamps
    end
  end
end
