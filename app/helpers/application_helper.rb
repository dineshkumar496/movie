# frozen_string_literal: true

module ApplicationHelper
  def search
    @q = Movie.ransack(params[:q])
  end
end
