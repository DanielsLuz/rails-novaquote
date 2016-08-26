class SlackWrapper

  def self.fetch_profile_pic(user_token)
    result = Net::HTTP.get(build_url(user_token))
    hash = JSON.parse result
    hash['user']['profile']['image_72']
  end

  private

  SLACK_API_URL = "https://slack.com/api"
  SLACK_API_METHOD = "/users.info?"
  SLACK_API_TOKEN = ENV['SLACK_API_TOKEN']

  def self.build_url(user_token)
    URI.parse(
      SLACK_API_URL + SLACK_API_METHOD + "token=" + SLACK_API_TOKEN +
      "&user=" + user_token + "&pretty=1"
    )
  end
end
