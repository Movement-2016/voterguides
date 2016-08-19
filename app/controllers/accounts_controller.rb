class AccountsController < ApplicationController
  load_and_authorize_resource class: "User", find_by: :secure_id

  def show
  end
end
