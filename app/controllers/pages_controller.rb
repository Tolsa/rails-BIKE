class PagesController < ApplicationController

  def home
    @entry = Entry.new
  end

end
