class Line::Designer
  include Line::Designer::Board
  include Line::Designer::Record
  include Line::Designer::Element

  def initialize(line_source, options={})
    @line_source = line_source
    @options = options
  end
end