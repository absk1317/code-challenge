class CompaniesController < ApplicationController
  before_action :set_company, except: %i[index create new]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show; end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: 'Saved'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: 'Changes Saved'
    else
      flash[:alert] = @company.errors.full_messages.join("<br/> ")
      render :edit
    end
  end

  def destroy
    if @company.destroy
      redirect_to companies_path, notice: 'Deleted'
    else
      redirect_to company_path(@company)
    end
  end

  private

  def company_params
    params.require(:company)
          .permit(
            :name,
            :legal_name,
            :description,
            :zip_code,
            :phone,
            :email,
            :owner_id,
            services: []
          )
  end

  def set_company
    @company = Company.find(params[:id])
  end
end
