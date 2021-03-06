module parser


pub struct ParserData {
	name string
	url string
	parser string
	config string
}

pub struct StaticParserConfig {
	node string
}

pub struct ParsedData {
	prise f32
	status string
}