<?php
define('HYVOR_TALK_SSO_PRIVATE_KEY', 'MY_PRIVATE_KEY'); // best way is using .env

function hyvorTalkSignon($user) {

    $userData = [];
    if ($user) {
        $userData = [
            'id' => $user['id'],
            'name' => $user['name'],
            'email' => $user['email'],
            'picture' => $user['picture'],
            'url' => $user['url']
        ];
    }

    $encodedUserData = base64_encode(json_encode($userData));
    $hash = hash_hmac('sha1', $encodedUserData, HYVOR_TALK_SSO_PRIVATE_KEY);


    return [
        'userData' => $encodedUserData,
        'hash' => $hash
    ];

}

$user = [
    'id' => 1,
    'name' => 'Example User',
    'email' => 'some@example.com',
    'picture' => 'https://example.com/picture.png',
    'url' => 'https://example.com'
];
$signon = hyvorTalkSignon($user);

?>

<!-- Hyvor Talk Installation Code -->
<div id="hyvor-talk-view"></div>
<script type="text/javascript">
    var HYVOR_TALK_WEBSITE = YOUR_WEBSITE_ID
    var HYVOR_TALK_CONFIG = {
        url: false,
        id: false,
        sso: {
            hash: "<?= $signon['hash'] ?>",
            userData: "<?= $signon['userData'] ?>",
            loginURL: "https://example.com/login",
            signupURL: "https://example.com/signup"
        }
    };
</script>
<script async type="text/javascript" src="//talk.hyvor.com/web-api/embed"></script>