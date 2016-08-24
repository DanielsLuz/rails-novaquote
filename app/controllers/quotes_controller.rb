class QuotesController < ApplicationController

  def index
  end

  def new_quote
    @quote = Quote.new()
    @quote.save

    redirect_to root_path
  end

  private

  def quote_params
    params.permit(:text, :author)
  end
end
