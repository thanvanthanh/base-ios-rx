all: brew-install install generate swiftgen open

brew-install:
	brew install mint libxml2

install:
	mint bootstrap
	bundle install

# generate
generate:
	mint run xcodegen xcodegen generate
	bundle exec pod install

# swiftgen
swiftgen:
	mint run swiftgen
# open xcode
open:
	xed .
