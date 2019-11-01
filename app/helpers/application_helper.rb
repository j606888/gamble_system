module ApplicationHelper
  def flash_class(level)
    case level.to_sym
        when :primary then "alert alert-primary"
        when :success then "alert alert-success"
        when :danger then "alert alert-danger"
        when :warning then "alert alert-warning"
        when :error then "alert alert-error"
        when :info then "alert alert-info"
        else "alert alert-info"
    end
  end

  def date_format_select
    [["2019/03", 'month'], ["2019-03-12", 'date'], ["2019-03-12 08:30 PM", 'hour'], ["2019-03-12 16:30:02", 'sec']]
  end
end
