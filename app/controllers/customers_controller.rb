# frozen_string_literal: true

class CustomersController < ApplicationController
  protect_from_forgery except: %i[show new create update]

  ACCESS_CONTROL_ALLOW_METHODS = %w(GET OPTIONS).freeze
  ACCESS_CONTROL_ALLOW_HEADERS = %w(Accept Origin Content-Type Authorization).freeze

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

  def preflight
    set_preflight_headers!
    head :ok
  end

  private

  def set_preflight_headers!
    response.headers['Access-Control-Max-Age'] = ACCESS_CONTROL_MAX_AGE
    response.headers['Access-Control-Allow-Headers'] = ACCESS_CONTROL_ALLOW_HEADERS.join(',')
    response.headers['Access-Control-Allow-Methods'] = ACCESS_CONTROL_ALLOW_METHODS.join(',')
  end

  def point
    params[:point] ? params[:point].to_i : 0
  end

  def customer_params
    params.require(:customer).permit(:uuid, :point)
  end
end
