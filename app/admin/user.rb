include PublicHelper
ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  permit_params :name, :email, :age, :gender, :avatar
  menu priority: 1, label: "list user", if: proc{ test }

  collection_action :add_custom_menu, :method => :get do
    render plain: "successfuly"
  end

  index do
    selectable_column
    id_column
    column :avatar do |user|
      show_image(user.avatar)
    end
    column :name
    column :email
    column :gender do |user|
      show_gender(user.gender)
    end
    actions do |user|
      a "<span class='btn btn-success'>Xem</span>".html_safe, href: admin_user_path(user)
      link_to "<span class='btn btn-warning'>chuyển giới ))</span>".html_safe, gender_changing_path(user.id), method: :post, data: { confirm: 'Are you sure?' }
    end
  end

  collection_action :change_name_u7, method: :get do
    u = User.find_by_id(7)
    @name = u.name
    render template: :change_name_u7
  end

  collection_action :define_a_method, method: :get do
  end

  controller do
    def define_a_method
      # r = Random.new.rand(0..20).to_s
      n = params[:a]
      u = User.find_by_id(7)
      u.name = n
      u.save
      redirect_to admin_users_path 
    end
  end

end
