ActiveAdmin.register User do
  actions :all, except: [:new, :create]

  permit_params :name, :email, :admin

  scope :all, default: true
  scope :admin
  scope :suspended

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
    panel "Secure ID" do
      f.object.to_param
    end
    f.inputs :name, :email, :admin
    f.actions
  end

  controller do
    defaults finder: :find_by_secure_id
  end

  batch_action :suspend do |ids|
    batch_action_collection.find(ids).each do |user|
      user.touch :suspended_at
    end
    redirect_to collection_path, alert: "the users have been suspended"
  end

  batch_action :unsuspend do |ids|
    batch_action_collection.find(ids).each do |user|
      user.update_attributes suspended_at: nil
    end
    redirect_to collection_path, alert: "the guides have been unsuspended"
  end
end
