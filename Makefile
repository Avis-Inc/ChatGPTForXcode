.PHONY: install
install:
	brew install xcodegen

.PHONY: generate
generate:
	xcodegen generate
	open ChatGPTForXcode.xcodeproj
