ActiveAdmin.register VoterGuide do
  actions :all, except: [:new, :create]

  permit_params :name, :target_city, :target_state, :election_date, :external_guide_url, :description

  form do |f|
    f.semantic_errors
    f.inputs :name, :target_city, :target_state, :election_date, :external_guide_url, :description
    if f.object.author
      panel "Author" do
        link_to f.object.author.name, edit_admin_user_path(f.object.author)
      end
    end

    if f.object.endorsements.any?
      table_for f.object.endorsements do
        column(:endorsement) { |e| e.presenter.summary_text }
        column(:actions) { |e| link_to "edit", edit_voter_guide_path(e.voter_guide) }
      end
    end

    f.actions

  end

  batch_action :publish do |ids|
    batch_action_collection.find(ids).each do |vg|
      vg.touch :published_at
    end
    redirect_to collection_path, alert: "the guides have been published"
  end

  batch_action :unpublish do |ids|
    batch_action_collection.find(ids).each do |vg|
      vg.update_attributes published_at: nil
    end
    redirect_to collection_path, alert: "the guides have been unpublished"
  end

  batch_action :recommend do |ids|
    batch_action_collection.find(ids).each do |vg|
      vg.touch :recommended_at
    end
    redirect_to collection_path, alert: "the guides have been recommended"
  end

  batch_action :unrecommend do |ids|
    batch_action_collection.find(ids).each do |vg|
      vg.update_attributes recommended_at: nil
    end
    redirect_to collection_path, alert: "the guides have been unrecommended"
  end

  filter :author_name, as: :string
  filter :name, label: "Guide Name"
  filter :target_city
  filter :target_state, as: :select, collection: -> { GeographyPresenter::ELIGIBLE_STATES.map(&:first) }

  scope :all, default: true
  scope :published
  scope :upcoming
  scope :recommended

  index do
    selectable_column
    column :id
    actions defaults: false do |vg|
    end
    column(:name) do |vg|
      "#{link_to(vg.name, voter_guide_path(vg))} |
      #{link_to("Edit", edit_admin_voter_guide_path(vg), class: "edit_link member_link")}".html_safe
    end
    column(:location) { |vg| vg.presenter.location_text }
    column(:election_date) { |vg| vg.election_date.strftime("%Y-%m-%d")}
    column(:published) { |vg| vg.published? ? status_tag("yes", :gray) : ""}
    column(:recommended) { |vg| vg.recommended? ? status_tag("yes", :gray) : ""}
    column(:author) { |vg| link_to vg.author.name, admin_user_path(vg.author) }
    column(:link_or_image) { |vg| vg.external_guide_url.present? ? status_tag("yes", :ok) : "" }
  end

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


end
