# frozen_string_literal: true

# payment requests controller
#
class PaymentRequestsController < ApplicationController
  before_action :set_employee
  before_action :set_payment_request, only: %i[show edit update destroy]

  # GET /payment_requests
  def index
    @payment_requests = @employee.payment_requests
  end

  # GET /payment_requests/1
  def show; end

  # GET /payment_requests/new
  def new
    @payment_request = PaymentRequest.new
  end

  # GET /payment_requests/1/edit
  def edit; end

  # POST /payment_requests
  def create
    @payment_request = PaymentRequest.new(payment_request_params)
    if @payment_request.save
      redirect_to payment_requests_path(employee_id: @payment_request.employee.id), notice: 'Created Successfully'
    else
      @employee = @payment_request.employee
      render :new
      # redirect_to payment_requests_path(employee_id: @payment_request.employee.id), notice: @payment_request.errors
    end
  end

  # PATCH/PUT /payment_requests/1
  def update
    if @payment_request.update(payment_request_params)
      redirect_to @payment_request, notice: 'Payment request was successfully updated.'
    else
      @employee = @payment_request.employee
      render :edit
    end
  end

  # DELETE /payment_requests/1
  def destroy
    @payment_request.destroy
    redirect_to payment_requests_url, notice: 'Payment request was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment_request
    @payment_request = PaymentRequest.find(params[:id])
  end

  def set_employee
    @employee = Employee.find_by(id: params[:employee_id])
  end

  # Only allow a list of trusted parameters through.
  def payment_request_params
    params.require(:payment_request).permit(:amount, :currency, :description, :status, :employee_id)
  end
end
