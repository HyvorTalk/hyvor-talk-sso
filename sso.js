const crypto = require('crypto-js');

/**
 * dependencies
 *  - crypto-js
 */



function hyvorTalkSignon(user) {
    const HYVOR_TALK_SSO_PRIVATE_KEY = 'MY_PRIVATE_KEY'; // this is not recommended. Use .env instead

    const userData = Buffer.from(JSON.stringify(user)).toString('base64');
    const hash = crypto.HmacSHA1(userData, HYVOR_TALK_SSO_PRIVATE_KEY).toString();

    return {
        userData,
        hash
    }
}

const signon = hyvorTalkSignon({
    id: 1,
    name: 'Example User',
    email: 'some@example.com',
    picture: 'https://example.com/picture.png',
    url: 'https://example.com'
});

const installationCode = `
<div id="hyvor-talk-view"></div>
<script type="text/javascript">
    var HYVOR_TALK_WEBSITE = YOUR_WEBSITE_ID
    var HYVOR_TALK_CONFIG = {
        url: false,
        id: false,
        sso: {
            hash: "${signon.hash}",
            userData: "${signon.userData}",
            loginURL: "https://example.com/login"
        }
    };
</script>
<script async type="text/javascript" src="//talk.hyvor.com/web-api/embed"></script>`;

// now send the installationCode to the front-end