class PatientsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @patients = Patient.all
    render json: @patients
  end

  def search_name
    @patient = Patient.where(name: params[:name])
    render json: @patient
  end

  def show
    @doctor = Patient.find(params[:id])
    render json: @doctor
  end

  def new
    @doctor = Patient.new
    render json: @doctor
  end

  def create
    @doctor = Patient.new(doctor_params)
    if @doctor.save
      render json: @doctor, status: :created
    else
      render json: @doctor.errors
    end
  end

  def edit
    @crud_update = Patient.find(params[:id])
  end

  def update
    @crud = Patient.find(params[:id])
    @crud.update(doctor_params)
    render json: @crud
  end

  def destroy
    @crud = Patient.find(params[:id])
    @crud.destroy
    render json: @crud
  end

  private

  def doctor_params
    params.require(:patient).permit(:name, :mo_no, :email, :address, :gender)
   
  end
end
