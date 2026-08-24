source "https://rubygems.org"

# Pinned for compatibility with system Ruby 2.6.10 (macOS default).
# If you upgrade Ruby (e.g. `brew install ruby` -> 3.x), you can switch back to:
#   gem "github-pages", group: :jekyll_plugins
# which tracks whatever Jekyll/plugin versions GitHub Pages actually runs in production.
gem "jekyll", "~> 3.9.0"
gem "kramdown-parser-gfm"
gem "webrick", "~> 1.8"

# Native-extension gems whose latest versions require Ruby >= 3.0
gem "ffi", "~> 1.15.5"
gem "google-protobuf", "~> 3.21.0"

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-sitemap"
end
