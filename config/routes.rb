Rails.application.routes.draw do
  #管理者側
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

get '/admin' => 'admin/homes#top'
namespace :admin do
  resources :items, only:[:new, :index, :show, :create, :edit, :update]
  resources :genres, only:[:index, :create, :edit, :update]
  resources :customers, only:[:index, :show, :edit, :update]
  resources :orders, only:[:show, :update]
  resources :order_items, only:[:update]
end


#顧客側
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

#退会確認画面
get '/customers/:id/unsubscribe' => 'public/customers#unsubscribe', as: 'unsubscribe'
#論理削除用のルーティング
patch '/customers/:id/withdrawal' => 'public/customers#withdrawal', as: 'withdrawal'

root 'public/homes#top'
get '/about' => 'public/homes#about'
scope module: :public do
    resources :items, only:[:index, :show]
    resources :customers, only:[:show, :edit, :update]
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
    #カート関連
    resources :cart_items, only:[:index, :create, :update, :destroy] do
      collection do
        delete '/destroy_all' => 'cart_items#destroy_all'
      end
    end
    #注文情報入力・注文情報確認関連
    post '/orders/confirm' => 'public/orders/confirm'
    get '/orders/complete' => 'public/orders/complete'
    resources :orders, only:[:new, :index, :show, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
