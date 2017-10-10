Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	get 'sums' => 'sums#index'
	post 'sums' => 'sums#create'

	get 'filters' => 'filters#index'
	post 'filters' => 'filters#create'

	get 'intervals' => 'intervals#index'
	post 'intervals' => 'intervals#create'

	get 'lin_regressions' => 'lin_regressions#index'
	post 'lin_regressions' => 'lin_regressions#create'
end
