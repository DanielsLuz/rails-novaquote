require 'rails_helper'
require 'slack_wrapper'

RSpec.describe Quote, type: :model do

  let(:params) { 
    { text: "sample text", user_name: "author name", user_id: "WRONG TOKEN" } 
  }

  it 'returns the most recent quotes' do                                     
    first_quotes = []                                                              
    (1..10).to_a.each do |num|                                                     
      first_quotes << Quote.create(text: "Text #{num}", user_name: "User #{num}")  
    end                                                                            

    expect(Quote.most_recent).to match_array(first_quotes)                         

    last_quotes = []                                                               
    (1..10).to_a.each do |num|                                                     
      last_quotes << Quote.create(text: "Text #{num}", user_name: "User #{num}")   
    end                                                                            

    expect(Quote.most_recent).to match_array(last_quotes)                          
  end

  xit 'creates with profile pic fetched' do
    pending("Please configure this url according to your tests")
    profile_pic =
      "CONFIGURE URL"
    @quote = Quote.parse_params(params)
    @quote.save
    expect(Quote.last.profile_pic).to eq(profile_pic)
  end

  context 'when specifying author' do
    let(:params_with_author_on_text) { 
      { text: "\"sample text\" by @someAuthor", user_name: "author name" } 
    }

    let(:params) { 
      { text: "sample text", user_name: "author name" } 
    }

    it 'should create author with default user_name' do
      @quote = Quote.parse_params(params)
      @quote.save
      expect(Quote.last.user_name).to eq(params[:user_name])
    end

    it 'should create author with specific user_name' do
      @quote = Quote.parse_params(params_with_author_on_text)
      @quote.save
      expect(Quote.last.user_name).to eq("@someAuthor")
      expect(Quote.last.text).to eq("\"sample text\"")
    end
  end
end
