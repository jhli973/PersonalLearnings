
from twilio.rest import Client

# Your sid and auth token
account_sid ="ACa70f5b909573e642607c60530a831b48"
auth_token = "248398ecba4f21ab3250ab942ef46ea6"
client  = Client(account_sid, auth_token)


msg = client.messages.create(	
	body = "Hello, This message send from my python program. JH",
	to="+13012634221",
	from_="12404834589")
	