require 'rails_helper'
require 'slack_wrapper'

RSpec.describe Quote, type: :model do

  let(:params) { 
    { text: "sample text", user_name: "author name", user: "U24EBS1UM" } 
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

  it 'creates with profile pic fetched' do
    profile_pic =
      "https://secure.gravatar.com/avatar/611347217328fac750a04904fd2179c2.jpg?s=72&d=https%3A%2F%2Fa.slack-edge.com%2F66f9%2Fimg%2Favatars%2Fava_0022-72.png"
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
