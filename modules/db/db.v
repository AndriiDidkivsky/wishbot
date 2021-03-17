module db

import os
import parser

pub struct DB {
	folder string
	prev_path string
	curr_path string
}


pub fn new_db(folder string, prev string, curr string) &DB {
	return &DB{
		folder: folder
		prev_path: '${folder}/${prev}'
		curr_path: '${folder}/${curr}'
	}
}

pub fn(d DB) update(data []parser.ParsedResult) {
	content := data.map(serialize)
	println(content)
}


pub fn(d DB) init() {
	if !os.exists(d.folder) {
		os.mkdir(d.folder) or {
			panic('Cant create folder: ${err}')
		}
	}
	
	if !os.exists(d.prev_path) {
		os.create(d.prev_path) or {
			panic('cant create filte, ${err}')
		}
	}
	if !os.exists(d.curr_path) {
		os.create(d.curr_path) or {
			panic('cant create filte, ${err}')
		}
	}
}


fn serialize(record parser.ParsedResult) string {
	return '${record.name};${record.price};${record.status}'
}

fn deserialize(str string) &parser.ParsedResult {
	cols := str.split(';')
	return &parser.ParsedResult{
		name: cols[0],
		price: cols[1],
		status: cols[2]
	}
}