import base64
import hmac
from hashlib import sha1
import json

HYVOR_TALK_SSO_PRIVATE_KEY = b'MY_PRIVATE_KEY'

def hyvorTalkSignon(user):
    userData = base64.b64encode(json.dumps(user).encode()).decode()
    hash = hmac.new(HYVOR_TALK_SSO_PRIVATE_KEY, userData.encode(), sha1).hexdigest().rstrip("\n")

    return {
        'hash': hash,
        'userData': userData
    }

# logged out user
# signon = hyvorTalkSignon({})

# logged in user
signon = hyvorTalkSignon({
    'id': 1,
    'name': 'Example User',
    'email': 'some@example.com',
    'picture': 'https://example.com/picture.png',
    'url': 'https://example.com'
})

installationCode = """
<div id="hyvor-talk-view"></div>
<script type="text/javascript">
    var HYVOR_TALK_WEBSITE = YOUR_WEBSITE_ID
    var HYVOR_TALK_CONFIG = {
        url: false,
        id: false,
        sso: {
            hash: "%(hash)s",
            userData: "%(userData)s",
            loginURL: "https://example.com/login"
        }
    };
</script>
<script async type="text/javascript" src="//talk.hyvor.com/web-api/embed"></script>""" % {
    'hash': signon['hash'],
    'userData': signon['userData'],
}