module main

import os
import os.cmdline
import json

import db
import parser

const (
	FOLDER = 'STORE'
	PREV = 'prev'
	CURR = 'curr'
)

fn main () {
	token := cmdline.option(os.args, '--token', '')
	config_path := cmdline.option(os.args, '--config', '')
	
	if token == '' {
		panic('Bot token in required')
	}

    config := get_config(config_path) or {
		panic('Cant get config')
	}
	mut results := []parser.ParsedResult
	for cfg in config.sony {
		res := parser.parse(cfg)
		results << res
	}

	println(results)
	dbot := db.new_db(FOLDER, PREV, CURR)
	dbot.init()
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
