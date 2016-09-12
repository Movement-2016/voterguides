class GuideReport < ApplicationRecord
  belongs_to :reporter, class_name: "User"
  belongs_to :voter_guide
end
