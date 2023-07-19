ActiveAdmin.register Enrollment do

  actions :index, :show

  index do
    selectable_column
    id_column
    column :course do |c|
      c.course.course_name
    end
    column :student.name
    actions
  end

  filter :id
  filter :course
  filter :student.name

  show do 
    attributes_table do
    row :id
    row :student
    row :course do |c|
      c.course.course_name
    end
    row :status
  end
  end
end
