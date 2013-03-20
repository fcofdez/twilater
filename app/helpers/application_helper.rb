module ApplicationHelper

  # Given a controller returns active if current page is same as asked
  def active?(controller_name)
    current_page?(controller: controller_name) ? "active" : ""
  end
end
