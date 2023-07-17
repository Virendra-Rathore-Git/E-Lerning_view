ActiveAdmin.register Teacher do
  permit_params :name, :email, :password, :mobile
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :mobile
    actions
  end

  filter :id
  filter :name
  filter :email
  filter :mobile

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :mobile
      f.input :password
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :email, :mobile, :password_digest, :type
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :mobile, :password_digest, :type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
