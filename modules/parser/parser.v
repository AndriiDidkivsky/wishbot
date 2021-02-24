module parser

import net.http
import net.html


pub fn parse(options ParseOptions) {
	content := http.get(options.url) or {
		return 
	}
	// is waiting for the fix https://github.com/vlang/v/issues/8942
	dom := html.parse(content.text)
	println(content.text)
}



pub struct ParseOptions {
	url string
	price string
	status string
}

pub struct ParsedData {
	prise f32
	status string
}