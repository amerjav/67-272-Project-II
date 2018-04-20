Rails.application.routes.draw do
  
  resources :families
  resources :registrations
  resources :users
  resources :students
  resources :camps
  resources :camp_instructors
  resources :curriculums
  resources :instructors
  resources :locations
  
  get 'home', :to => 'home#home'
  get 'about', :to => 'home#about'
  get 'contact', :to => 'home#contact'
  get 'privacy', :to => 'home#privacy'
  
  root to: 'home#home'
  
end
