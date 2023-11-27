# frozen_string_literal: true

module ApplicationHelper
  def sort_arrow(column, current_sort, current_direction, default_sort_column = 'lastname')
    arrow = if current_sort.nil? && column == default_sort_column
      '↑' # Default sort arrow direction for the default column
    elsif current_sort == column
      current_direction == 'asc' ? '↑' : '↓'
    else
      '' # No arrow if it's not the current sorted column
    end
    content_tag(:span, arrow, class: 'sort-arrow').html_safe
  end
end
