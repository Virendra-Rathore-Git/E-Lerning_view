ActiveAdmin.register Category do
  actions :index , :show, :new, :create
  permit_params :cat_name

  index do
    selectable_column
    id_column
    column :cat_name
    actions
  end

  filter :cat_name
  filter :id
end
