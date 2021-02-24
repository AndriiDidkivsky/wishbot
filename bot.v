module main

import os
import os.cmdline

import telbot


fn main () {
	token := cmdline.option(os.args, '--token', '')
	
	if token == '' {
		panic('Bot token in required')
	}

	botapi := telbot.new_telbot(token)
	res := botapi.get_updates()
	println(res)
}
