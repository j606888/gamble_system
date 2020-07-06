class LineSourcesController < ApplicationController
  def index
    @line_sources = LineSource.all
  end
end