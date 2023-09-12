class SpecializationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @specializations = Specialization.all
    render json: @specializations
  end

  def show
    @specialization = Specialization.find(params[:id])
    render json: @specialization
  end

  def new
    @specialization = Specialization.new
    render json: @specialization
  end

  def create
    @specialization = Specialization.new(specialization_params)
    # puts "#{}"
    if @specialization.save
      render json: @specialization, status: :created
    else
      render json: @specialization.errors
    end
  end

  def edit
    @crud_update = Specialization.find(params[:id])
  end

  def update
    @crud = Specialization.find(params[:id])
    @crud.update(specialization_params)
    render json: @crud
  end

  def destroy
    @crud = Specialization.find(params[:id])
    @crud.destroy
    render json: @crud
  end

  private

  def specialization_params
    params.require(:specialization).permit(:area)
  end
end
