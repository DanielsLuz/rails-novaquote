class Quote < ActiveRecord::Base
  scope :most_recent, -> { select("id, text, user_name")
                           .order(created_at: :desc).limit(10) }
end
