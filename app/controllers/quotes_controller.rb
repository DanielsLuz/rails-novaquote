class QuotesController < ApplicationController

  def index
  end

  def new_quote
    @quote = Quote.parse_params(quote_params)
    @quote.save

    render :nothing => true, :status => 200
  end

  def most_recent
    render json: Quote.most_recent
  end
  private

  def quote_params
    params.permit(:text, :user_name)
  end
end
