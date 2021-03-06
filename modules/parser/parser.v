module parser

import json

pub fn parse(data ParserData) {
	if data.parser == 'static' {
		config := json.decode(StaticParserConfig, data.config) or {
			return
		}
	}
}