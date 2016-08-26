class SlackWrapper

  def self.fetch_profile_pic(user_token)
    result = Net::HTTP.get(build_url(user_token))
    hash = JSON.parse result
    hash['user']['profile']['image_72']
  end

  private

  SLACK_API_URL = "https://slack.com/api"
  API_METHOD = "/users.info?"
  API_TOKEN = "xoxp-72491650305-72487885973-72488819924-c3991481bb"

  def self.build_url(user_token)
    URI.parse(
      SLACK_API_URL + API_METHOD + "token=" + API_TOKEN +
      "&user=" + user_token + "&pretty=1"
    )
  end
end
