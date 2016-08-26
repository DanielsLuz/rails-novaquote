class QuotesController < ApplicationController

  def index
    @quotes = Quote.all
  end

  def new_quote
    @quote = Quote.new(quote_params)
    @quote.save

    render :nothing => true, :status => 200
  end

  private

  def quote_params
    params.permit(:text, :user_name)
  end
end