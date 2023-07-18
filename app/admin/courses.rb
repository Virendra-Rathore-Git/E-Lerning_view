ActiveAdmin.register Course do
  actions  :index, :show, :create

  index do
    selectable_column
    id_column
    column :course_name
    column :course_desc
    column :teacher.name
    column :category_id
    column :status
    actions 
  end

  filter :course_name
  filter :id
  filter :teacher.name

end
