Rails.application.routes.draw do
 namespace :api do
  namespace :v1 do

    scope module: :merchants do
      get 'merchants/find', to: 'merchants#find'
    end

    scope module: :items do
      get 'items/find_all', to: 'items#find_all'
    end
    
    resources :merchants, module: :merchants, only:[:show, :index] do 
      resources :items, only: [:index]
    end

    resources :items, module: :items, only: [:index, :show, :create, :destroy, :update] do
      resource :merchant, only: [:show]
    end

    namespace :revenue do
      resources :merchants, only: [:show, :index]
      resources :unshipped, only: [:index]
    end

    # #For Daterange breakout
    # resources :revenue, only: [:index]

    # namespace :revenue do
    #   #total revenue of given merchant, or all merchants
    #   resources :merchants, only: [:show, :index]
    #   #Top revenue by items
    #   resources :items, only: [:index]
    #   #Potential revenue
    #   resources :unshipped, only: [:index]
    #   #Weekly breakout
    #   resources :weekly, only: [:index]
    #   end
    end    
  end
end
