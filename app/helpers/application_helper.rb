module ApplicationHelper
  def flash_class(level)
    case level.to_sym
        when :primary then "alert alert-primary"
        when :success then "alert alert-success"
        when :danger then "alert alert-danger"
        when :warning then "alert alert-warning"
        when :error then "alert alert-error"
        when :info then "alert alert-info"
    end
  end
end
