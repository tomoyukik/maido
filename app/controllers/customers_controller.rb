# frozen_string_literal: true

class CustomersController < ApplicationController
  protect_from_forgery except: %i[show new create update]

  def show
    puts __method__
    @customer = Customer.find_by uuid: params[:uuid]
    @customer ||= Customer.create uuid: params[:uuid], point: Random.rand(1..100)
    render json: { point: @customer.point }
  end

  def new
    puts __method__
    uuids = Customer.all.map(&:uuid)
    uuid = Random.rand(11_111..99_999)
    uuid += 1 while uuids.include? uuid
    @customer = Customer.create(uuid: uuid)
    render json: { uuid: @customer.uuid }
  end

  def create
    puts __method__
    @customer = Customer.create customer_params
    render json: { customer: @customer.uuid }
  end

  def update
    puts __method__
    rqs = request.body.read.to_json
    json = JSON.parse rqs
    json = eval json
    puts json
    puts params
    uuid = params[:uuid]
    @customer = Customer.find_by uuid: params[:uuid]
    @customer ||= Customer.create uuid: params[:uuid], point: Random.rand(1..100)
    if params[:"#{uuid}"]
      score = 0 # @customer.point
      new_point = params[:"#{uuid}"].to_i
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
