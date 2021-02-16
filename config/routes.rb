Rails.application.routes.draw do
 namespace :api do
  namespace :v1 do
    
    resources :merchants, module: :merchants, only:[:show, :index] do 
      resources :items, only: [:index]
    end

    # resource :merchants, module: :merchants, only:[] do
    #   get 'merchants/find', to: 'merchants#find'
    # end

    scope module: :merchants do
      get 'merchants/find', to: 'merchants#find'
    end

    resources :items, module: :items, only: [:index, :show, :create, :destroy, :update] do
      resource :merchant, only: [:show]
    end

    # namespace :items do
    #   resources :find_all, controller: 'search', only: [:index]
    #   # resources :find, controller: 'search', only: [:index]
    # end

    # namespace :merchants do
    #   resources :find, controller: 'search', only: [:index]
    # #   # resources :find_all, controller: 'search', only: [:index]
    # end

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
