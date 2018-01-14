Rails.application.routes.draw do
  get 'styles/index'

  get 'artists/index'

  get 'welcome/index'

  post 'immersion/logout'
  post 'immersion/gallery/logout'
  post 'immersion/exhibits/logout'
  post 'immersion/admin/logout'

  resources :immersion do
    collection do
      resources :gallery do
        collection do
          get 'data'
        end
      end
      resources :exhibits do
        collection do
          get 'data'
        end
      end
      resources :artists do
        collection do
          get 'data'
        end
      end
      resources :styles do
        collection do
          get 'data'
        end
      end
      resources :login do
        collection do
          post 'submit'
        end
      end
      resources :search do
        collection do
          get 'input'
          post 'do_nothing'
        end
      end
      resources :admin do
        collection do
          get 'data'
          post 'add_art'
          post 'remove_art'
          post 'edit_art'
          post 'add_employee'
          post 'remove_employee'
          post 'edit_employee'
          get 'search_employee'
          post 'add_non_employee'
          post 'remove_non_employee'
          post 'edit_non_employee'
          get 'search_non_employee'
          post 'add_exhibit'
          post 'edit_exhibit'
          post 'remove_exhibit'
          get 'search_exhibit'
          post 'do_nothing'
        end
      end
    end
  end

  root 'welcome#index'
end
