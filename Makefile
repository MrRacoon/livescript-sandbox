.DEFAULT_GOAL := main

SRC = ./src
DEST   = ./dest
NODE_MODULES = ./node_modules

compile_livescript:
	@echo ""
	@echo "Compile all livescript"
	lsc -b -c $(SRC)/*.ls -o ${DEST}/js

init:
	@echo ""
	@echo "ensure the dest folder is availible"
	mkdir -p $(DEST)
	@echo ""
	@echo "install all npm dependencies"
	npm install

clean:
	@echo ""
	@echo "remove dest and node_modules"
	$(RM) -r $(DEST)
	$(RM) -r $(NODE_MODULES)

concat:
	@echo ""
	@echo "Remove old (or interfering) index.js"
	$(RM) $(DEST)/index.js
	@echo ""
	@echo "Concat all js files int index.js"
	cat ${DEST}/js/*.js > ${DEST}/index.js

move_static:
	@echo ""
	@echo "Copy index.html"
	cp ./src/index.html ./dest/
	cp ./src/style.css ./dest/

open_firefox:
	@echo ""
	@echo "opening firefox"
	firefox $(DEST)/index.html 2> /dev/null

watch:
	lsc -cw $(SRC)/index.ls -o $(DEST)

open_chrome:
	@echo ""
	@echo "opening google-chrome"
	google-chrome $(DEST)/index.html 2> /dev/null &

main: init move_index_html compile_livescript concat

recompile: clean main

test: main open_chrome

