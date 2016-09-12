class QuotesController < ApplicationController
  before_action :validate_token, only: [:new_quote]

  def index
  end

  def new_quote
    @quote = Quote.parse_params(quote_params)
    @quote.save

    render nothing: true, status: 200
  end

  def most_recent
    render json: Quote.most_recent
  end
  private

  def quote_params
    params.permit(:text, :user_name, :user_id)
  end

  def validate_token
    unless params[:token] == ENV["SLACK_COMMAND_TOKEN"]
    render nothing: true, status: 403
    end
  end
end
