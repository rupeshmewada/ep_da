class PatientsController < ApplicationController
  # before_action :authenticate_admin!

  # before_action :authorize_request, only: %i[show]
  # before_action :find_doctor, except: %i[create index]
  # before_action :authorize_request, only: %i[index, show]

  skip_before_action :verify_authenticity_token

  def index
    @patients = Patient.all
  
    name= @patients[0]
    puts "------========---------#{@patients[0].name}==================="
    puts "------========---------#{name}==================="
    render json: @patients
  end

  def search_name
    @patient = Patient.where(name: params[:name])
    render json: @patient
  end

  def show
    @patient = Patient.find(params[:id])
    render json: @patient
  end

  def new
    @patient = Patient.new
    render json: @patient
  end

  def create
    # debugger
    @patient = Patient.new(patient_params)
    if @patient.save
      render json: @patient, status: :created
    else
      render json: @patient.errors
    end
  end

  def edit
    @patient_update = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    @patient.update(patient_params)
    render json: @patient
  end

  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
    render json: {msg:"delete succr", show: @patient}
  end

  private

  def patient_params
    params.require(:patient).permit(:name, :mo_no, :email, :address, :gender, :date)
   
  end
end
