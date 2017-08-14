include PublicHelper
ActiveAdmin.register Book do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :user_id, :name, :price, :sale
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  menu parent: "users"

  index do
    selectable_column
    id_column
    column :price do |book|
      format_money(book.price)
    end
    column :sale
    column :user
    actions
  end
end
