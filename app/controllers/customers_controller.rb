# frozen_string_literal: true

class CustomersController < ApplicationController
  protect_from_forgery except: %i[show create update]

  def show
    @customer = Customer.find_by uuid: params[:uuid]
    @customer ||= Customer.create uuid: params[:uuid], point: Random.rand(1..100)
    render json: { point: @customer.point }
  end

  def new
    uuids = Customer.all.map(&:uuid)
    uuid = Random.rand(11_111..99_999)
    uuid += 1 while uuids.include? uuid
    @customer = Customer.create(uuid: uuid)
    render json: { uuid: @customer.uuid }
  end

  def create
    @customer = Customer.create customer_params
    render json: { customer: @customer.uuid }
  end

  def update
    puts params
    @customer = Customer.find_by uuid: params[:uuid]
    @customer ||= Customer.create uuid: params[:uuid], point: Random.rand(1..100)
    if params[:customer][:point]
      score = @customer.point
      new_point = params[:customer][:point].to_i
      @customer.update(score + new_point)
    end
    render json: {
      customer: @customer.uuid,
      point: @customer.point
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
