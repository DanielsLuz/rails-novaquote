class Quote < ActiveRecord::Base
  scope :most_recent, -> { select("id, text, user_name")
                           .order(created_at: :desc).limit(10) }

  def self.parse_params(params = {})
    delimiter = "\" by "
    if(params[:text].include?(delimiter))
      params[:text], params[:user_name] = params[:text].split(delimiter)
    end
    new(params)
  end
end
