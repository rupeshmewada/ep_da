class DoctorsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # def index
  #   if params[:search]
  #     @doctors = Doctor.search(params[:search]).order("created_at DESC")
  #     puts "#{@doctors.name}"

  #     # render json: @doctors
  #   else
  #     @doctors = Doctor.all.order("created_at DESC")
  #     puts "#{@doctors.name}"
  #     # render json: @doctors
  #   end
  # end

  def index
    @doctors = Doctor.all.order("created_at DESC")
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
    

    if (location != nil && specilization != nil)
      @doctor = Doctor.where(specilization: specilization).where(location: location)
    elsif (location != nil)
      @doctor = Doctor.where(location: location)
    elsif (specilization != nil)
      @doctor = Doctor.where(specilization: specilization)
    else
      @doctor = Doctor.all
    end

    render json: @doctor
  end

  # def city_specilization_search

  #   @doctor = Doctor.where(location: params[:location]).where(specilization: params[:specialization])
  #   render json: @doctor

  # end

  def search_name
    @doctor = Doctor.where(name: params[:name])
    puts " hello #{@doctor} hello"
    render json: @doctor
  end

  def show
    @doctor = Doctor.find(params[:id])
    render json: @doctor
  end

  def image
    @image = Doctor.find(params[:id]).image
    render json: @image.download, type: @image.content_type, disposition: "inline"
  end

  def new
    @doctor = Doctor.new
    # render json: @doctor
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      # render json: @doctor, status: :created
      redirect_to @doctor
    else
      # render json: @doctor.errors
      render :new
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

  def doctor_params
    params.require(:doctor).permit(:name, :email, :specilization, :mo_no, :location, :fees, :image)
  end
end
