ActiveAdmin.register User do
  actions :all, except: [:new, :create]

  permit_params :name, :email, :admin

  scope :all, default: true
  scope :admin

  filter :name
  filter :email

  index do
    selectable_column
    column :id
    column :name
    column :email
    column :admin
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs :name, :email, :admin
    f.actions
  end

end
