ActiveAdmin.register Course do
  permit_params :course_name, :course_desc, :teacher_id, :category_id, :status

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

  form do |f|
    f.inputs do
      f.input :course_name
      f.input :course_desc
      f.input :teacher.name
      f.input :category_id
    end
    f.actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :course_name, :course_desc, :teacher_id, :category_id, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:course_name, :course_desc, :teacher_id, :category_id, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
