module parser

import json

pub fn parse(data ParserConfig) {
	if data.parser == 'foxtrot' {
		new_foxtrot_parser(data.name, data.url).handle()
		// new_foxtrot_parser(data.name).handle(data.url)
	}
}