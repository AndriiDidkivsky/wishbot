module telbot

import net.http
import json
import time

pub struct TelBot {
	pub: 
	    token string [required]
		endpoint string = "https://api.telegram.org/bot"
}


pub fn new_telbot(token string) TelBot {
	return {
		token: token
	}
}

pub fn (bot TelBot) get_me() User {
	res := bot.make_request("getMe", "")
	decoded := json.decode(User, res) or {
		return User{}
	}
	return decoded
}

fn (bot TelBot) make_request(method string, body string) string {
	res := http.post_json('${bot.endpoint}${bot.token}/${method}', body) or {
		println("unable to send request")
		return ""
	}
	if res.status_code == 200 {
		decoded := json.decode(ResponseOK, res.text) or { 
			println("Failed to decode json")
			return ""
		}
		return decoded.result
	} else {
		decoded := json.decode(ResponseNotOK, res.text) or { 
            println("Failed to decode json")
            return ""
        }
		println("\n\nError!\nMethod: ${method}\nTime: " + time.now().str() + "\nError code: " + decoded.error_code.str() + "\nDescription: " + decoded.description)
		return ""
	}

}

struct User {
	pub: 
	    id int
		is_bot bool
		first_name string
		last_name string
		username string
		language_code string
		can_join_groups bool
		can_read_all_group_messages bool
		supports_inline_queries bool
}


pub struct ResponseOK {
	pub:
		ok bool                
		result string [raw]          
}

pub struct ResponseNotOK {
	pub:
		ok bool                
		error_code int                 
		description string        
}