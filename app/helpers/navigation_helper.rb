module NavigationHelper
  def navigate_days_links
    [previous_day_link, today_link, next_day_link].compact.join(' | ').html_safe
  end

  def previous_day_link
    if given_date_is_in_the_past?
      link_to 'Previous day', by_date_expenses_path(parsed_given_date - 1)
    else
      link_to 'Yesterday', by_date_expenses_path(Date.today - 1)
    end
  end

  def next_day_link
    unless path_represents_today? || given_date_is_yesterday?
      link_to 'Next day', by_date_expenses_path(parsed_given_date + 1)
    end
  end

  def today_link
    unless path_represents_today?
      link_to 'Today', today_expenses_path
    end
  end

  private
  def given_date_is_in_the_past?
    Date.today - 1 >= parsed_given_date
  end

  def given_date_is_yesterday?
    Date.today - 1 == parsed_given_date
  end

  def path_represents_today?
    [today_expenses_path, root_path].include?(request.path)
  end

  def parsed_given_date
    params[:date].present? ? Date.parse(params[:date]) : Date.today
  end
end
