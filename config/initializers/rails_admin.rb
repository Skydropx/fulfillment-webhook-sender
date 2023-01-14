RailsAdmin.config do |config|
  config.asset_source = :sprockets

  config.authorize_with do
    authenticate_or_request_with_http_basic('Login required') do |username, password|
      auth_user_name = ENV['ADMIN_USERNAME']
      auth_user_pass = ENV['ADMIN_PASSWORD']
      username == auth_user_name && password == auth_user_pass
    end
  end


  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
