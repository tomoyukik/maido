# frozen_string_literal: true

class CustomersController < ApplicationController
  protect_from_forgery except: %i[show create update]

  def show
    puts params
    @customer = Customer.find_by uuid: params[:uuid]
    @customer ||= Customer.create uuid: params[:uuid]
    render json: { status: 'SUCCESS', point: @customer.point }
  end

  def create
    puts params
    @customer = Customer.create customer_params
    render json: { status: 'SUCCESS', customer: @customer.uuid }
  end

  def update
    puts params
    @customer = Customer.find_by uuid: params[:uuid]
    @customer ||= Customer.create uuid: params[:uuid]
    new_point = params[:point]
    @customer.point += new_point
    render json: {
      status: 'SUCCESS', customer: @customer.uuid, point: @customer.point
    }
  end

  private

  def customer_params
    params.require(:customer).permit(:uuid, :point)
  end
end
