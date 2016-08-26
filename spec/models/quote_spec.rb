require 'rails_helper'

RSpec.describe Quote, type: :model do
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
end
