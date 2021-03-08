module parser

import json

pub fn parse(data ParserConfig) {
	if data.parser == 'foxtrot' {
		res := new_foxtrot_parser(data.name).handle(data.url)
		println(res)
		// new_foxtrot_parser(data.name).handle(data.url)
	}
}