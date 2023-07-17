ActiveAdmin.register Enrollment do
  permit_params :course_id, :student_id, :status

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

  form do |f|
    f.inputs do
      f.input :student.name
      f.input :course_id
    end
    f.actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :course_id, :student_id, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:course_id, :student_id, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
