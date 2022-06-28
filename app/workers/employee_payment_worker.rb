# frozen_string_literal: true

# contractor/app/workers/employee_payment_workers.rb
class EmployeePaymentWorker
  include Sneakers::Worker
  from_queue('employee_queue')

  def work(payment_request_status)
    Rails.logger.info('*' * 100)
    params = JSON.parse payment_request_status
    Rails.logger.debug params
    Rails.logger.debug '*' * 100
    request = PaymentRequest.find_by(id: params[:id])

    Rails.logger.debug '#' * 100
    Rails.logger.debug request
    Rails.logger.debug '#' * 100
    request.update(status: params[:status])

    Rails.logger.debug '#' * 100
    Rails.logger.debug request
    Rails.logger.debug '#' * 100
    # request is received in queue

    ack!
  end
end
