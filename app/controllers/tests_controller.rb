class TestsController < ApplicationController
 
    skip_before_action :verify_authenticity_token
  
    def index
      @tests = Test.all
      render json: @tests
    end
  
    def show
      @test = Test.find(params[:id])
      render json: @test
    end
  
    def new
      @test = Test.new
      render json: @test
    end
  
    def create
      # debugger
      @test = Test.new(test_params)
      if @test.save
        render json: @test, status: :created
      else
        render json: @test.errors
      end
    end
  
    def edit
      @crud_update = Test.find(params[:id])
    end
  
    def update
      @crud = Test.find(params[:id])
      @crud.update(test_params)
      render json: @crud
    end
  
    def destroy
      @crud = Test.find(params[:id])
      @crud.destroy
      render json: @crud
    end
  
    private
  
    def test_params
      params.require(:test).permit(:name,:no)
    end
  
end
