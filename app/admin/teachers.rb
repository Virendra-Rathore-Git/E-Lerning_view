ActiveAdmin.register Teacher do
  permit_params :name, :email, :password, :mobile
    actions :index, :show,:new,:create, :destroy

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
end
