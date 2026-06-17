run:
	bundle3.2 exec jekyll serve --livereload

build:
	bundle3.2 exec jekyll build

fmt:
	npx prettier --write .
