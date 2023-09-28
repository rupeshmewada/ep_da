class AppointmentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    
    if params[:doctor_id]
    @doctor = Doctor.find(params[:doctor_id])
    @appointments = @doctor.appointments.all
    render json: @appointments

    elsif params[:patient_id]
      @patient = Patient.find(params[:patient_id])
      @appointments = @patient.appointments.all
      render json: @appointments

    else
    @appointments = Appointment.all
    render json: @appointments

    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    render json: @appointment
  end

  def new
    @appointment = Appointment.new
    render json: @appointment
  end

  def pat_create
    # debugger
    @doctor = Doctor.find(params[:doctor_id])
    @patient = Patient.create!(name: params[:name], mo_no: params[:mo_no], email: params[:email], address: params[:address], gender: params[:gender], date: params[:date])
    
    @appointment_params = {date: Date.today,time: Time.now , doctor_id: @doctor.id, patient_id: @patient.id }
    # render json: {doc: @doctor, pat:@patient}
    puts "-----------------------#{@appointment_params}======-="

    @appointment = Appointment.new(@appointment_params)
    if @appointment.save 
      render json: @appointment 
    else 
      render json: @appointment.error 
    end
  end


  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      render json: @appointment, status: :created
    else
      render json: @appointment.errors
    end
  end


  def edit
    @crud_update = Appointment.find(params[:id])
  end

  def update
    @crud = Appointment.find(params[:id])
    @crud.update(appointment_params)
    render json: @crud
  end

  def destroy
    @crud = Appointment.find(params[:id])
    @crud.destroy
    render json: @crud
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :time, :doctor_id, :patient_id)
  end
end
