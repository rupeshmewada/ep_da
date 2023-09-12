class DoctorsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def index
      @doctor = Doctor.all.order(id: :desc)
      render json: @doctor
    end
    
    def area
      @doctor = Doctor.where(specilization: params[:specilization])
      puts " hello #{@doctor} hello"
      render json: @doctor
    end

    def search_name
      @doctor = Doctor.where(name: params[:name])
      puts " hello #{@doctor} hello"
      render json: @doctor
    end
  
    def show
      @doctor = Doctor.find(params[:id])
      render json: @doctor
    end
  
    def new
      @doctor = Doctor.new
      render json: @doctor
    end
  
    def create
      @doctor = Doctor.new(doctor_params)
      if @doctor.save
        render json: @doctor, status: :created
      else
        render json: @doctor.errors
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
      params.require(:doctor).permit(:name, :email, :specilization, :mo_no, :location, :fees)
    end
  
end
