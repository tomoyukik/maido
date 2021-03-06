# frozen_string_literal: true

class CustomersController < ApplicationController
  protect_from_forgery except: %i[show new create update]

  ACCESS_CONTROL_ALLOW_METHODS = %w[GET OPTIONS].freeze
  ACCESS_CONTROL_ALLOW_HEADERS = %w[Accept Origin Content-Type Authorization].freeze
  ACCESS_CONTROL_MAX_AGE = '1728000'

  skip_before_action :verify_authenticity_token, only: %i[preflight]

  def show
    Rails.logger.debug __method__
    @customer = Customer.find_by uuid: params[:uuid]
    @customer ||=
      Customer.create(
        uuid: params[:uuid],
        point: Random.rand(1..100),
        point_added: true
      )
    render json: { point: @customer.point }
  end

  def new
    Rails.logger.debug __method__
    uuids = Customer.all.map(&:uuid)
    uuid = Random.rand(11_111..99_999)
    uuid += 1 while uuids.include? uuid
    @customer = Customer.create(uuid: uuid)
    hit = 0
    if choose
      @customer.update(point: 300)
      hit = 1
    end
    render json: { uuid: @customer.uuid, hit: hit }
  end

  def create
    Rails.logger.debug __method__
    @customer = Customer.create customer_params
    render json: { customer: @customer.uuid }
  end

  def update
    Rails.logger.debug __method__
    @customer = Customer.find_by uuid: params[:uuid]
    @customer ||=
      Customer.create(
        uuid: params[:uuid],
        point: Random.rand(1..100),
        point_added: true
      )
    current = @customer.point
    if params[:customer] && params[:customer][:point]
      @customer.update(point: current + params[:customer][:point].to_i)
    elsif !@customer.point_added
      @customer.update(point: current + 10, point_added: true)
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

  def choose(weight = 50)
    rand <= weight / 100.0
  end
end
