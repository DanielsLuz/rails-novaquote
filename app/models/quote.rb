require 'slack_wrapper'

class Quote < ActiveRecord::Base
  scope :most_recent, -> { select("id, text, user_name, profile_pic")
                           .order(created_at: :desc).limit(10) }

  def self.parse_params(params = {})
    delimiter = "\" by "
    if(params[:text].include?(delimiter))
      params[:text], params[:user_name] = params[:text].split(" by ")
    end

    if(params[:user_id])
      params[:profile_pic] = profile_pic(params[:user_id])
    end

    new(params.except(:user_id))
  end

  private

  def self.profile_pic(user)
    SlackWrapper.fetch_profile_pic(user)
  end
end
