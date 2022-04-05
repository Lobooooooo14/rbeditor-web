require 'sinatra'

set :protection, :except => :frame_options
set :bind, '0.0.0.0'
set :port, 8080
enable :sessions

get '/' do
 session["code"] = ""
  erb :index, :locals => {:output => "", :code=>session["code"]}
end

post "/run" do
  File.open("tmp.rb","w") do |f|
    f.write params[:code]
  end

  session["code"] = params[:code]

  out = `ruby tmp.rb`.gsub("\n","<br>")

  File.open("tmp.rb","w") { |f| f.write ""}
  
  #system("rm -rf tmp.rb")
  
  erb :index, :locals => {:output=> out, :code=>session["code"]}
end
