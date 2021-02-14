Rails.application.routes.draw do
 namespace :api do
  namespace :v1 do
    # namespace :merchants do
    #   resources :find, controller: 'search', only: [:index]
    #   resources :find_all, controller: 'search', only: [:index]
    # end
    
    resources :merchants, module: :merchants, only:[:show, :index] do 
      resources :items, only: [:index]
    end

    resources :items, only: [:index, :show, :create, :destroy] do
      resources :merchants, only: [:index]
    end
    
    # , :new, :create, :show, :edit, :update, :destroy

    # namespace :items do
    #   resources :find_all, controller: 'search', only: [:index]
    # end

    # resources :revenue, module: :revenue, only: [:index] do
    #   resources :merchants, only: [:index, :show]
    #   resource :items, only: [:index]
    #   resources :unshipped, only: [:index]
    #   resources :weekly, only: [:index]
    #   end
    end    
  end
end
