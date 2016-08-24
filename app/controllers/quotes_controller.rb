class QuotesController < ApplicationController

  def index
  end

  def new_quote
    @quote = Quote.new(quote_params)
    @quote.save

    debugger
    render :nothing => true, :status => 200
  end

  private

  def quote_params
    params.permit(:text, :author)
  end
end
