# ActiveAdmin.register User do
# permit_params :email, :status
# actions :index , :show ,:edit,:update
# scope :active, group: :status
# scope :inactive, group: :status
#   index do
#     selectable_column
#     id_column
#     column :name
#     column :email
#     column :mobile
#     column :type
#     column :status
#     actions
#   end

#   show do
#   attributes_table do
#   row :email
#   row :name
#   row :mobile
#   row :type
#   row :status
#   end
#   end
  
#   filter :id
#   filter :name
#   filter :email
#   filter :type

#   form do |f|
#     f.inputs do
#       f.input :email , input_html: { readonly: true }
#       f.input :status, as: :select
#     end
#     f.actions
#   end
# end
