class Admin::SignsController < ApplicationController
  # acts_as_token_authentication_handler_for Admin
  before_action :set_admin_sign, only: [:show]

  respond_to :html, :json

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 20
    # @admin_signs = Sign.all.paginate(page: page, per_page: per_page)
    @admin_signs = Sign.all.default_order.page(params[:page]).per(params[:per_page])
    respond_with(@admin_signs)
  end

  def show
    respond_with(@admin_sign)
  end

  private
    def set_admin_sign
      @admin_sign = Sign.find(params[:id])
    end
end
