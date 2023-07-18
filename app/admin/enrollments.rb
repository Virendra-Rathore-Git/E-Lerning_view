ActiveAdmin.register Enrollment do

  actions :index, :show

  index do
    selectable_column
    id_column
    column :course_id
    column :student.name
    actions
  end

  filter :id
  filter :course_id
  filter :student.name
end
