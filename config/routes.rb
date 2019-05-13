Rails.application.routes.draw do
  # get 'games/new'
  # get 'games/score'

  get 'new', to: 'games#new'
  post 'score', to: 'games#score', as: :score
end
