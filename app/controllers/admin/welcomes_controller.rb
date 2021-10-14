class Admin::WelcomesController < ApplicationController
  before_action :set_admin_welcome, only: %i[ show edit update destroy ]

  # GET /admin/welcomes or /admin/welcomes.json
  def index
    @admin_welcomes = Admin::Welcome.all
  end

  # GET /admin/welcomes/1 or /admin/welcomes/1.json
  def show
  end

  # GET /admin/welcomes/new
  def new
    @admin_welcome = Admin::Welcome.new
  end

  # GET /admin/welcomes/1/edit
  def edit
  end

  # POST /admin/welcomes or /admin/welcomes.json
  def create
    @admin_welcome = Admin::Welcome.new(admin_welcome_params)

    respond_to do |format|
      if @admin_welcome.save
        format.html { redirect_to @admin_welcome, notice: "Welcome was successfully created." }
        format.json { render :show, status: :created, location: @admin_welcome }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_welcome.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/welcomes/1 or /admin/welcomes/1.json
  def update
    respond_to do |format|
      if @admin_welcome.update(admin_welcome_params)
        format.html { redirect_to @admin_welcome, notice: "Welcome was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_welcome }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_welcome.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/welcomes/1 or /admin/welcomes/1.json
  def destroy
    @admin_welcome.destroy
    respond_to do |format|
      format.html { redirect_to admin_welcomes_url, notice: "Welcome was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_welcome
      @admin_welcome = Admin::Welcome.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_welcome_params
      params.require(:admin_welcome).permit(:index)
    end
end
