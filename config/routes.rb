# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :customers, only: %i[show new create update], param: :uuid
  get 'customers/:uuid/update', to: 'customers#update', param: :uuid
  match '*path' => 'customers#preflight', via: :options
end
