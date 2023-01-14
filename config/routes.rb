Rails.application.routes.draw do
  root to: lambda { |_env|
    response = '<h2>Webhooks sender service.</h2>'
    [200, { 'Content-Type' => 'text/html' }, [response]]
  }
end
