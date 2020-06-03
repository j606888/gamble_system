class LineBot::Designer
  include LineBot::Designer::Board
  include LineBot::Designer::Record
  include LineBot::Designer::Element

  def initialize(line_source, options={})
    @line_source = line_source
    @options = options
  end
end