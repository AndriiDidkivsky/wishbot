module main

import os
import os.cmdline

import parser
import json


fn main () {
	token := cmdline.option(os.args, '--token', '')
	config_path := cmdline.option(os.args, '--config', '')
	
	if token == '' {
		panic('Bot token in required')
	}

    config := get_config(config_path) or {
		println(err)
		panic('Cant get config')
	}

	for cfg in config.sony {
		parser.parse(cfg)
	}

	
}


fn get_config (path string) ?ParserConfiguration {
	config_exists := os.exists(path)
	
	if !config_exists {
		return error('Config ${path} not found')
	}

	config_content := os.read_file(path) or {
		return error('Cant read file')
	}

    config := json.decode(ParserConfiguration, config_content) or {
		return error(err)
	}
	return config
}


struct ParserConfiguration {
	sony []parser.ParserConfig
}