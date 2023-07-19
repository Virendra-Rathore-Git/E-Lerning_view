ActiveAdmin.register Course do
  actions  :index, :show, :create

  index do
    selectable_column
    id_column
    column :course_name
    column :course_desc
    column :teacher
    column :category do |c|
            c.category.cat_name
    end
    column :status
    actions 
  end
 
  filter :id, label: 'Course Id'
  filter :course_name, as: :check_boxes
  filter :category_id, filters: [:start , :end]
  filter :teacher.name

  show do
    attributes_table do
      row :course_name
      row :course_desc
      row :teacher
      row :category do |c|
        c.category.cat_name
      end
      row :status
    end
  end
end
