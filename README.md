
## Base-ios

Welcome to Base-ios which is doing whatever!

## Getting started

First, you will need a few tools to start working on Base-ios:

##  `Xcode`: From the app store or wherever

## Ruby install
  <img src="https://www.ruby-lang.org/images/header-ruby-logo.png">
  
- Check ruby version:
  ```
  rbenv install -l
  ```
- Install latest ruby:
  ```
  rbenv install 2.7.2 && rbenv rehash
  ```
- As needed, set ruby version using global, local, shell options:
  ```
  rbenv global 2.7.2
  ```
## [Bundler](http://bundler.io):
  <img src="http://bundler.io/images/header_transparent_bg.png" width=200>

```
 gem install bundler
  ```
 ## [Mint](https://github.com/yonaskolb/mint) 🌱:
  ```
  brew install mint
  ```

Then run `make` to have a valid project ready to be used.
```
make
```

### Makefile

- `make all`: configure the project as a new one (mainly used for the CI)
- `make install`:
  - install gem dependencies
  - Isntall Bundle
- `make generate`: generate a new new xcodeproj
- `make swiftgen`: reload swiftgen assets, ib, localizables, ...

## Documentation

- [Scripts](Documentations/Scripts.md)
- [Fastlane's README](fastlane/README.md)
