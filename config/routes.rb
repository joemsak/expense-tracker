Rails.application.routes.draw do
  root to: 'expenses#today'

  resources :expenses, only: [:new, :create] do
    collection do
      get :today
      get 'by_date/:date', to: 'expenses#by_date', as: :by_date
    end
  end
end
