class DoctorsController < ApplicationController
  # protect_from_forgery with: :null_session
  # before_action :authenticate_admin!

  # before_action :authorize_request, except: %i[create, index]
  # before_action :authorize_request, only: %i[show]

  # before_action :find_doctor, except: %i[create index]

  skip_before_action :verify_authenticity_token

  def index
    @doctors = Doctor.all.order('created_at DESC')
    render json: @doctors
  end

  def area
    @doctor = Doctor.where(specilization: params[:specilization])
    render json: @doctor
  end

  def city_search
    @doctor = Doctor.where(location: params[:location])
    render json: @doctor
  end

  def search
    location = params[:location]
    specilization = params[:specilization]

    @doctor = if !location.nil? && !specilization.nil?
                Doctor.where(specilization: specilization).where(location: location)
              elsif !location.nil?
                Doctor.where(location: location)
              elsif !specilization.nil?
                Doctor.where(specilization: specilization)
              else
                Doctor.all
              end

    render json: @doctor
  end

  # def city_specilization_search

  #   @doctor = Doctor.where(location: params[:location]).where(specilization: params[:specialization])
  #   render json: @doctor

  # end
  def doctor_all_appointmentent
    # debugger
    @ids = []
    @doctor = Doctor.find(params[:id])
    @appointments = @doctor.appointments.all

    @appointments.each do |item|
      # puts "-----#{item.patient_id}------"
      @ids << item.patient_id
    end
    render json: @appointments

    # @all_patient_data = Patient.find(@ids)
    # @doctorsdetails = Doctor.joins(patients: :appointments).select("patients.id","patients.name","patients.mo_no","patients.address","patients.email","patients.gender", "appointments.date","appointments.time")
    # @doctorsdetails = Doctor.joins(patients: :appointments).select("patients.id","patients.name","patients.mo_no","patients.address","patients.email","patients.gender", "appointments.date","appointments.time")
    # @doctorsdetails = Doctor.joins(:patients)
    # render json: @doctorsdetails
  end

  def doc_pat
    @doctor = Doctor.find(params[:id])
    @allpat = @doctor.patients.all
    render json: @allpat
  end

  def search_name
    @doctor = Doctor.where(name: params[:name])
    puts " hello #{@doctor} hello"
    render json: @doctor
  end

  def show
    @doctor = Doctor.find(params[:id])
    if @doctor.image.attached?
      @im = url_for(@doctor.image)
      render json: { "doctor": @doctor, "image": @im }
    else
      render json: { "doctor": @doctor }
    end
  end

  def image
    @image = Doctor.find(params[:id]).image
    render json: @image.download, type: @image.content_type, disposition: 'inline'
  end

  def new
    @doctor = Doctor.new
    # render json: @doctor
  end

  def create
    # debugger
    @doctor = Doctor.new(doctor_params)

    # image = params[:image]

    # if image.present?
    #   @doctor.image.attach(image)
    # end

    if @doctor.save
      render json: @doctor, status: :created
      # redirect_to @doctor
    else
      render json: @doctor.errors
      # render :new
    end
  end

  def edit
    @crud_update = Doctor.find(params[:id])
  end

  def update
    @crud = Doctor.find(params[:id])
    @crud.update(doctor_params)
    render json: @crud
  end

  def destroy
    @crud = Doctor.find(params[:id])
    @crud.destroy
    render json: @crud
  end

  private

  # def find_doctor
  #   @user = Doctor.find_by_name!(params[:name])
  #   rescue ActiveRecord::RecordNotFound
  #     render json: { errors: 'User not found' }, status: :not_found
  # end

  def doctor_params
    params.require(:doctor).permit(:name, :email, :specilization, :mo_no, :location, :fees, :password, :image)
  end
end
