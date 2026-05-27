# frozen_string_literal: true

# ApplicationHelper contains application behavior.
module ApplicationHelper
  def user_login_path
    ShibbolethLogin.enabled? ? shibboleth_login_path : new_user_session_path
  end

  def sort_arrow(column, current_sort, current_direction, default_sort_column = 'lastname')
    arrow = if current_sort.nil? && column == default_sort_column
              '↑' # Default sort arrow direction for the default column
            elsif current_sort == column
              current_direction == 'asc' ? '↑' : '↓'
            else
              '' # No arrow if it's not the current sorted column
            end
    content_tag(:span, arrow, class: 'sort-arrow')
  end
end
