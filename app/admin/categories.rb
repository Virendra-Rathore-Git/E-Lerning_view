ActiveAdmin.register Category do
  permit_params :cat_name

  index do
    selectable_column
    id_column
    column :cat_name
    actions
  end

  filter :cat_name
  filter :id

  form do |f|
    f.inputs do
      f.input :cat_name
    end
    f.actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :cat_name
  #
  # or
  #
  # permit_params do
  #   permitted = [:cat_name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
