module Dashboard
  class AdminUsersController < BaseController
    before_action :set_admin_user, only: %w[show edit update destroy]
    helper_method :order_params

    def index
      service = Search::AdminUsersService.new(params)
      @admin_users = service.execute
    end

    def edit; end

    def show; end

    def update
      respond_to do |format|
        if @admin_user.update(admin_user_params)
          format.html { redirect_to dashboard_admin_users_url, notice: 'AdminUser was successfully updated.' }
          format.json { render :show, status: :ok, location: @admin_user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: dashboard_admin_users_url.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @admin_user.destroy
      respond_to do |format|
        format.html { redirect_to dashboard_admin_users_url, notice: 'AdminUser was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def order_params(order, direction)
      params.merge(o: order, d: direction, page: params[:page]).permit(:o, :d, :page)
    end

    private

    def set_admin_user
      @admin_user = AdminUser.find_by(id: params[:id])
    end

    def admin_user_params
      params.require(:admin_user).permit(
        :created_at, :updated_at, :email, :name, :password, :email, :age, :address, :phone
      )
    end
  end
end
