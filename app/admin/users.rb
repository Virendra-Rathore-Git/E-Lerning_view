ActiveAdmin.register User do
permit_params :email, :status, :password
actions :index , :show ,:edit,:update
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :mobile
    column :type
    column :status
    actions
  end
  
  filter :id
  filter :name
  filter :email
  filter :type

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :status
    end
    f.actions
  end
end
