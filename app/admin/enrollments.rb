ActiveAdmin.register Enrollment do

  actions :index, :show

  index do
    selectable_column
    id_column
    column :course
    column :student.name
    actions
  end

  filter :id
  filter :course
  filter :student.name
end
