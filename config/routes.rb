Rails.application.routes.draw do
  root to: 'expenses#today'

  resources :expenses, only: [:new, :create] do
    get :today, on: :collection
  end
end
