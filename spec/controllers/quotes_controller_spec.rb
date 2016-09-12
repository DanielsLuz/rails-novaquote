require 'rails_helper'

RSpec.describe QuotesController, type: :controller do

  context 'receiving a get request' do

    let(:valid_params) { 
      { text: "sample text", user_name: "author name" } 
    }

    it 'creates a new quote' do
      expect(Quote.all.size).to eq(0)

      post :new_quote, valid_params

      expect(Quote.all.size).to eq(1)
    end

    it 'creates a correct quote' do
      post :new_quote, valid_params

      quote = Quote.last
      expect(quote.text).to eq(valid_params[:text])
      expect(quote.user_name).to eq(valid_params[:user_name])
    end
  end

  context 'returning most recent quotes' do                                        
                                                                                   
    it 'returns the correct json' do                                               
      quotes = []                                                                  
      (1..10).to_a.each do |num|                                                   
        quotes << Quote.create(text: "Text #{num}", user_name: "User #{num}",
                              profile_pic: "profile_pic")   
      end                                                                          
      quotes = quotes.reverse.to_json(only: [:id, :text, :user_name,
                                             :profile_pic])              
                                                                                   
      get :most_recent                                                             
                                                                                   
      expect(response.body).to eq(quotes)                                          
    end                                                                            
  end
end
