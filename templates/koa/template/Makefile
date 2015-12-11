
#
# Binaries
#

export PATH := ./node_modules/.bin/:$(PATH)
BIN := ./node_modules/.bin

#
# Variables
#

PORT = 8080

#
# Tasks
#

start: node_modules
	@foreman start --port $(PORT)

watch: node_modules
	@nodemon --exec 'make start' -q

clean:
	@rm -rf node_modules

#
# Shorthands
#

install: node_modules

#
# Targets
#

node_modules: package.json
	@npm install

#
# Phony
#

.PHONY: watch clean
