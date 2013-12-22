phpunit:
	cmd.run:
		names:
			- pear config-set auto_discover 1
			- pear clear-cache
			- pear install pear.phpunit.de/PHPUnit
