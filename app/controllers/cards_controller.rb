class CardsController < ApplicationController

#   require "payjp"

#   def new
#     card = Card.where(user_id: current_user.id)
#     redirect_to action: "show" if card.exists?
#   end

#   def pay #payjpとCardのデータベース作成を実施します。
#     Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
 
#     if params['payjp-token'].blank?
#       redirect_to action: "new"
#     else
#       customer = Payjp::Customer.create(
#       # description: '登録テスト', #なくてもOK
#       # email: current_user.email, #なくてもOK
#       card: params['payjp-token'],
#       metadata: {user_id: current_user.id}
#       ) #念の為metadataにuser_idを入れましたがなくてもOK
#       @card = Card.new(user_id: current_user.id, customer_id: customer_id, card_id: customer.card_id)
#       if @card.save
#         redirect_to action: "show"
#       else
#         redirect_to action: "pay"
#       end
#     end
#   end

#   def delete #PayjpとCardデータベースを削除します
#     card = Card.where(user_id: current_user.id).first
#     if card.blank?
#     else
#       Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
#       customer = Payjp::Customer.retrieve(card.customer_id)
#       customer.delete
#       card.delete
#     end
#       redirect_to action: "new"
#   end

#   def show #Cardのデータpayjpに送り情報を取り出します
#     card = Card.where(user_id: current_user.id).first
#     if card.blank?
#       redirect_to action: "new" 
#     else
#       Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
#       customer = Payjp::Customer.retrieve(card.customer_id)
#       @default_card_information = customer.cards.retrieve(card.card_id)
#     end
#   end
# end

  # require "payjp"
  
  def show
    @card = Card.find(params[:id])
  end

  def new
    @card = Card.new
  end


  def create
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])
  end

  def destroy
  end

#   def pay
#     Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
#     charge = Payjp::Charge.create(
#     # amount: @product.price,
#     amount: 300,
#     card: params['payjp-token'],
#     currency: 'jpy'
#     )
#     redirect_to done_products_path
# end

  # def pays #payjpとCardのデータベース作成を実施します。
  #   Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  #   if params['payjp-token'].blank?
  #     redirect_to action: "new"
  #   else
  #     customer = Payjp::Customer.create(
  #     description: '登録テスト', #なくてもOK
  #     email: current_user.email, #なくてもOK
  #     card: params['payjp-token'],
  #     metadata: {user_id: current_user.id}
  #     ) #念の為metadataにuser_idを入れましたがなくてもOK
  #     @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
  #     if @card.save
  #       redirect_to action: "show"
  #     else
  #       redirect_to action: "pay"
  #     end
  #   end
  # end

  # def show #Cardのデータpayjpに送り情報を取り出します
  #   card = Card.where(user_id: current_user.id).first
  #   if card.blank?
  #     redirect_to action: "new" 
  #   else
  #     Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  #     customer = Payjp::Customer.retrieve(card.customer_id)
  #     @default_card_information = customer.cards.retrieve(card.card_id)
  #   end
  # end
end
