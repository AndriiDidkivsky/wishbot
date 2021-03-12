module parser

import json

pub fn parse(data ParserConfig) ParsedResult{
	// mut result := []
	// if data.parser == 'foxtrot' {
		return new_foxtrot_parser(data.name, data.url).handle()
	// }

}