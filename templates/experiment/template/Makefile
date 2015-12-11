
#
# Binaries
#

export PATH := ./node_modules/.bin:$(PATH)
BIN := ./node_modules/.bin

#
# Variables
#

HOST     ?= localhost
PORT     ?= 8080

SCRIPTS   = $(shell find source -type f -name '*.js')
STYLES    = $(shell find source -type f -name '*.css')

ASSETS    = build/index.html build/404.html

TRANSFORM = -t [ babelify --loose all ]
BROWSERS  = "last 2 versions"

#
# Tasks
#

build: assets scripts styles

watch: install
	@make -j3 watch-server watch-css watch-assets
watch-server:
	@budo source/js/index.js:assets/bundle.js \
		--dir build \
		--port $(PORT) \
		--live \
		-- $(TRANSFORM) | garnish
watch-css:
	@cssnext --watch source/css/index.css build/assets/bundle.css
watch-assets:
	@watch make assets --silent

install: node_modules

clean:
	@rm -rf build
clean-deps:
	@rm -rf node_modules/

#
# Shorthands
#

assets: $(ASSETS)
scripts: build/assets/bundle.js
styles: build/assets/bundle.css

#
# Targets
#

node_modules: package.json
	@npm install

build/%: source/%
	@mkdir -p $(@D)
	@cp $< $@

build/assets/%.js: $(SCRIPTS)
	@mkdir -p $(@D)
	@browserify $(TRANSFORM) source/js/index.js -o $@

build/assets/%.css: $(STYLES)
	@mkdir -p $(@D)
	@cssnext --browsers $(BROWSERS) --sourcemap $< $@

#
# These tasks will be run every time regardless of dependencies.
#

.PHONY: develop clean clean-deps
