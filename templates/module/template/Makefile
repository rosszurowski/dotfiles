
#
# Binaries
#

BIN := ./node_modules/.bin

#
# Tasks
#

test: node_modules
	@$(BIN)/ava

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

.PHONY: test clean
