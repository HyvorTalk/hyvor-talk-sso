require 'base64'
require 'openssl'
require 'json'

HYVOR_TALK_SSO_PRIVATE_KEY = 'MY_PRIVATE_KEY'
HYVOR_TALK_SSO_ID = 1

userData = {}

def hyvorTalkSignon(user)

    encodedUserData = Base64.encode64( user.to_json ).gsub("\n", "")
    hash = OpenSSL::HMAC.hexdigest('sha1', HYVOR_TALK_SSO_PRIVATE_KEY, encodedUserData)

    return {
        'userData': encodedUserData,
        'hash': hash
    }

end

# logged out user
# user = {}

# logged in user
user = {
    'id': 1,
    'name': 'Example User',
    'email': 'some@example.com',
    'picture': 'https://example.com/picture.png',
    'url': 'https://example.com'
}
signon = hyvorTalkSignon(user)

installationCode = <<-END
    <!-- Hyvor Talk Installation Code -->
    <div id="hyvor-talk-view"></div>
    <script type="text/javascript">
        var HYVOR_TALK_WEBSITE = YOUR_WEBSITE_ID
        var HYVOR_TALK_CONFIG = {
            url: false,
            id: false,
            sso: {
                id: #{HYVOR_TALK_SSO_ID},
                hash: "#{signon[:hash]}",
                userData: "#{signon[:userData]}",
                loginURL: "https://example.com/login",
                signupURL: "https://example.com/signup"
            }
        };
    </script>
    <script async type="text/javascript" src="//talk.hyvor.com/web-api/embed"></script>
END

# add the installationCode in to the HTML template