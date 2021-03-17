module db

import os

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

pub fn(d DB) update() {

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