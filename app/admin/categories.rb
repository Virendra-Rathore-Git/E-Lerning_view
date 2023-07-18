ActiveAdmin.register Category do
  actions :index , :show

  index do
    selectable_column
    id_column
    column :cat_name
    actions
  end

  filter :cat_name
  filter :id
end
