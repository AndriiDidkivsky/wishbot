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
		panic('Cant get config')
	}
	mut results := []parser.ParsedResult
	for cfg in config.sony {
		res := parser.parse(cfg)
		results << res
	}

	println(results)

	get_settings('settings.cfg') or {
		panic('cant read settings')
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

fn get_settings(path string) ?AppSettings {
	settings_content := os.read_file(path) or {
		return error('Cant read settings')
	}
	rows := settings_content.split('\n')
	mut settings_map := map[string]string{}
	for row in rows {
		pair := row.split(':')
		settings_map[pair[0]] = pair[1]
	}

	mut app_settings := AppSettings{
		prepath: settings_map['prepath']
		curpath: settings_map['curpath']
	}
	
	return app_settings
	
}


struct ParserConfiguration {
	sony []parser.ParserConfig
}

struct AppSettings {
	prepath string
	curpath string
}