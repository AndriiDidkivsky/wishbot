module parser

const (
	NOT_AVAILABLE = 'Нема в наявності'
	PRE_PURCHASE = 'Передзамовлення'
	AVAILABLE = 'Є в наявності'
)

pub struct ParserConfig {
	name string
	url string
	parser string
}

pub struct ParsedResult {
	name string
	price string
	status string
}
