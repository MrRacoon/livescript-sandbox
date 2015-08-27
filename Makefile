.DEFAULT_GOAL := main

SOURCE = ./src
DEST   = ./dest

compile_livescript:
	lsc -b -c src/*.ls  -o ${DEST}/js || echo "no ls files"
	lsc -b -c src/*.lls -o ${DEST}/js || echo "no lls files"

src:
	vim $(SOURCE)

clean:
	$(RM) -rf $(DEST)/*

concat:
	# Remove old (or interfering) index.js
	$(RM) $(DEST)/index.js
	cat ${DEST}/js/*.js > ${DEST}/index.js

move_index_html:
	cp ./src/index.html ./dest/

open_firefox:
	firefox $(DEST)/index.html

main: clean move_index_html compile_livescript concat

test: main open_firefox

