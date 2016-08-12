ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: "#{SITE_NAME} Admin" do
    columns do
      column do
        panel "Guides by Election Date" do
          ul do
            VoterGuide.group(:election_date).order(election_date: :desc).count.each do |election_date, guide_count|
              li "#{election_date.strftime("%Y-%m-%d")}: #{guide_count}"
            end
          end
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
