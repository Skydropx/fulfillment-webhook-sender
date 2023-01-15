# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: lambda { |_env|
    response = '<h2>Webhooks sender service.</h2>'
    [200, { 'Content-Type' => 'text/html' }, [response]]
  }
end
