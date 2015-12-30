Rails.application.routes.draw do
  get 'expenses/new'

  resources :expenses, only: [:new, :create] do
    get :today, on: :collection
  end
end
