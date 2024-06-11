Rails.application.routes.draw do
  resources :students do
    resources :section_students, shallow: true
  end
  resources :students, only: [:index]
  resources :teachers do
    resources :teacher_subjects, shallow: true
  end
  resources :subjects
  root to: 'subjects#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
