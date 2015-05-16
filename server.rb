require 'sinatra'

get '/pressure' do
  send_file 'pressure.png'
end

not_found do
  status 404
end
