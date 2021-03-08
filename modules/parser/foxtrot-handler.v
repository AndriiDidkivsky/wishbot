module parser

import net.http
import net.html
import os




pub struct FoxtrotParser {
	name string
	url string
}


const status_map = map {
	'0': 'NOT_AVAILABLE',
	'1': 'PRE_PURCHASE',
	'2': 'AVAILABLE',
}


pub fn new_foxtrot_parser(name string, url string) FoxtrotParser {
	return FoxtrotParser{name: name, url: url}
}

pub fn(p FoxtrotParser) handle() ParsedResult {
	headers := map{
		'authority': 'www.foxtrot.com.ua',
		'cache-control': 'max-age=0',
		'sec-fetch-mode': 'navigate',
		'sec-fetch-site': 'none',
		'sec-fetch-dest': 'document'
		'sec-fetch-user': '?1',
		'accept-language': 'en-US,en;q=0.9',
		'upgrade-insecure-requests': '1',
		'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
		'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36',
	}
	req := http.Request {
		method: .get,
		url: p.url,
		headers: headers
	}
	res := req.do() or {
		return ParsedResult{}
	}

	mut dom := html.parse(res.text)
	tags := dom.get_tag_by_attribute_value('class', 'product-box__content')

	if tags.len == 0 {
		return ParsedResult{} 
	} 

	tag := tags[0]
	price := tag.attributes['data-price']
	status := tag.attributes['data-availability']

	return ParsedResult {
		name: p.name,
		price: price,
		status: status_map[status]
	}
}
