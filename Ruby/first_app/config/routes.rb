Rails.application.routes.draw do
  get 'greeter/hello'
  get 'greeter/hello' => "greeter#hello"
  get 'greeter/goodbay'
end
