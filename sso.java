import java.util.HashMap;
import java.util.Base64;

import org.apache.commons.codec.digest.HmacAlgorithms;
import org.apache.commons.codec.digest.HmacUtils;
import org.json.simple.JSONObject;

public class Sso {

	public static void main(String[] args) {
		HashMap<String, String> signon = hyvorTalkSignon();
		
		String userData = signon.get("userData"));
		String hash = signon.get("hash"));
	}

	public static HashMap<String, String> hyvorTalkSignon() {
		String SECRET_KEY = "MY_PRIVATE_KEY";

		User user = new User();
		JSONObject userJson = new JSONObject();

		if (user.isLoggedIn) {
			userJson.put("id", user.id);
			userJson.put("name", user.name);
			userJson.put("email", user.email);
			userJson.put("picture", user.picture);
			userJson.put("url", user.url);
		}

		String userBase64 = Base64.getEncoder().encodeToString(userJson.toString().getBytes());		
		String hash = new HmacUtils(HmacAlgorithms.HMAC_SHA_1, SECRET_KEY).hmacHex(userBase64);

		HashMap<String, String> signon = new HashMap<String, String>();
		signon.put("userData", userBase64); 
		signon.put("hash", hash); 
		return signon;
	}

}

/**
* User Class example
* 
    public class User {	
        boolean isLoggedIn = true;
        
        int id = 103004;
        String name = "Example User";
        String email = "some@example.com";
        String picture = "https://example.com/picture.png";
        String url = "https://example.com";
        
    }
*/