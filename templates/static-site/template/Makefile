
#
# Binaries
#

BIN := ./node_modules/.bin

#
# Variables
#

PORT      ?= 8080
NODE_ENV  ?= development

LAYOUTS    = $(shell find layouts -type f -name '*.html')
CONTENT    = $(shell find content  -type f -name '*.md')
STYLES     = $(shell find assets -type f -name '*.css')
SCRIPTS    = $(shell find assets -type f -name '*.js')

BROWSERS   = "last 1 version, > 10%"
TRANSFORMS = -t [ babelify --presets [ es2015-loose ] ] -t envify

REPO       = {{repository}}
BRANCH     = $(shell git rev-parse --abbrev-ref HEAD)

#
# Tasks
#

build: install assets content styles
	@bin/build

clean:
	@rm -rf build
clean-deps:
	@rm -rf node_modules

deploy:
	@echo "Deploying branch \033[0;33m$(BRANCH)\033[0m to Github pages..."
	@make clean
	@NODE_ENV=production make build
	@(cd build && \
		git init -q . && \
		git add . && \
		git commit -q -m "Deployment (auto-commit)" && \
		echo "\033[0;90m" && \
		git push "git@github.com:$(REPO).git" HEAD:gh-pages --force && \
		echo "\033[0m")
	@echo "Deployed to \033[0;32m{{domain}}\033[0m"

#
# Shorthands
#

install: node_modules

content: build/index.html
assets: build/favicon.png build/assets/mark.svg build/assets/img/
styles: build/assets/bundle.css
scripts: build/assets/bundle.js

#
# Targets
#

node_modules: package.json
	@npm install

build/index.html: bin/build $(CONTENT) $(LAYOUTS)
	@bin/build

build/%: assets/%
	@mkdir -p $(@D)
	@cp -r $< $@

build/assets/%: assets/%
	@mkdir -p $(@D)
	@cp -r $< $@

build/assets/bundle.css: $(STYLES)
	@mkdir -p $(@D)
	@cssnext --browsers $(BROWSERS) --sourcemap assets/css/index.css $@
	@if [[ "$(NODE_ENV)" == "production" ]]; then cleancss --s0 $@ -o $@; fi

build/assets/bundle.js: $(SCRIPTS)
	@mkdir -p $(@D)
	@browserify $(TRANSFORMS) assets/js/index.js -o $@
	@if [[ "$(NODE_ENV)" == "production" ]]; then uglifyjs $@ -o $@; fi

#
# Phony
#

.PHONY: clean clean-deps
