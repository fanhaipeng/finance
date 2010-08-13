class ConfigController < ApplicationController
  before_filter :set_active_tab

  def index
  end

  private

  def set_active_tab
    @activetab = 4
  end

end
