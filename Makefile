run:
	bundle3.2 exec jekyll serve --livereload --incremental

build:
	bundle3.2 exec jekyll build --incremental

fmt:
	npx prettier --write .
