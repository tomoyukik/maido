# frozen_string_literal: true

class CustomersController < ApplicationController
  protect_from_forgery except: %i[show create update]

  def show
    @customer = Customer.find_by uuid: params[:uuid]
    @customer ||= Customer.create uuid: params[:uuid]
    score = @customer.point
    @customer.update(point: score + point) if params[:point]
    render json: { status: 'SUCCESS', point: @customer.point }
  end

  def create
    @customer = Customer.create customer_params
    render json: { status: 'SUCCESS', customer: @customer.uuid }
  end

  def update
    @customer = Customer.find_by uuid: params[:uuid]
    @customer ||= Customer.create uuid: params[:uuid]
    new_point = params[:point]
    @customer.point += new_point
    render json: {
      status: 'SUCCESS', customer: @customer.uuid, point: @customer.point
    }
  end

  private

  def point
    params[:point] ? params[:point].to_i : 0
  end

  def customer_params
    params.require(:customer).permit(:uuid, :point)
  end
end
