require 'rails_helper'

RSpec.describe QuotesController, type: :controller do

  context 'receiving a post request' do

    before :each do
      ENV["SLACK_COMMAND_TOKEN"] = "correct_token"
    end

    let(:valid_params) { 
      { text: "sample text", user_name: "author name", token: "correct_token" } 
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

    it 'dont create with incorrect token' do
      expect(Quote.all.size).to eq(0)

      params_without_token = {
        text: "sample text",
        user_name: "author name",
        token: "incorrect_token"
      }
      post :new_quote, params_without_token

      expect(Quote.all.size).to eq(0)
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
