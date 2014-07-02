configure do
  set :root,    File.dirname(__FILE__)
  set :views,   File.join(Sinatra::Application.root, 'views')
  require 'action_mailer'
  require 'pry'
  require 'json'
  require File.join(Sinatra::Application.root, 'lib', 'mailer')


  enable :cross_origin
  set :allow_origin, :any
  set :allow_methods, [:get, :post, :options]
  set :allow_credentials, true
  set :allow_headers, settings.allow_headers + ['X-Requested-With']#, ["*", "Content-Type", "Accept", "AUTHORIZATION", "Cache-Control"]

  if production?
    ActionMailer::Base.smtp_settings = {
      :address => "smtp.sendgrid.net",
      :port => '25',
      :authentication => :plain,
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :domain => ENV['SENDGRID_DOMAIN'],
    }
  else
    ActionMailer::Base.smtp_settings = {
      :address => "localhost",
      :port => '1025',
    }
  end

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.view_paths = File.join(Sinatra::Application.root, 'views')
end



#############################################################################################################

get '/debug' do
  extra = (params[:extra] || {}).merge( referer: request.referer)
  Mailer.contact('ariera@gmail.com', 'hola dola tela catola', extra).deliver
end

post '/send_email' do
  begin
    cross_origin
    extra = (params[:extra] || {}).merge( referer: request.referer)
    Mailer.contact(params[:from], params[:body], extra).deliver
  ensure
    unless request.xhr?
      redirect params[:return_to] || back
    end
  end
end

options '/send_email' do
  cross_origin
end
