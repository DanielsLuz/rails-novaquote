#README

This is a simple rails application that register text sent through a slack command as quotes, with the profile picture of the sender and an author.

Just configure your command to send a POST request to the `/new_quote` endpoint.

Usage
-----
Suppose you created a command `/novaquote`, that triggers the **/new_quote** endpoint (as said above).
Now you can register quotes directly from your slack chat! It currently supports two syntaxes:

- /novaquote This text will be send as a quote.
- /novaquote "This text will be send as a quote, but with the author defined" by Some author

Quote sent, now you can verify it at the root URL of your deployed application!

The page is currently showing the last 10 quotes sent.

The quote's page looks for new quotes every 5 seconds. If any new quotes are found, it will display it automatically. 
If the number of quotes is above 10, it will erase the oldest ones and show only the 10 most recent ones.

Setup
------
The app needs a Slack API token so it can fetch the profile picture of the command sender. 
You can generate a test token at: https://api.slack.com/docs/oauth-test-tokens

At your deployment server, set an environment variable `SLACK_API_TOKEN` with your token. Ex:

SLACK_API_TOKEN="YOUR-SLACK-API-TOKEN" *note the double quotes*

TODO
-----
- **Validate the slack command token sent on the request!** (*Currently, any slack command that points to this application endpoint will trigger a quote creation*)
