require 'rails_helper'

RSpec.describe QuotesController, type: :controller do

  context 'receiving a get request' do

    let(:valid_params) { 
      { text: "sample text", author: "author name" } 
    }

    it 'creates a new quote' do
      expect(Quote.all.size).to eq(0)

      get :new_quote, valid_params

      expect(Quote.all.size).to eq(1)
    end

    it 'creates a correct quote' do
      get :new_quote, valid_params

      quote = Quote.last
      expect(quote.text).to eq(valid_params[:text])
      expect(quote.author).to eq(valid_params[:author])
    end
  end
end
