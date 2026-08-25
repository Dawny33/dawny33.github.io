# jrajrohit.me

Personal site and blog of Jalem Raj Rohit. Jekyll, hosted on GitHub Pages.

- **[data__wizard](https://twitter.com/data__wizard)** on Twitter/X
- **[/in/jalemrajrohit](https://www.linkedin.com/in/jalemrajrohit)** on LinkedIn

---

## Writing a post by hand

Drop a markdown file into `_posts/` named `YYYY-MM-DD-some-slug.md`:

```markdown
---
title: The title of the post
date: 2026-08-24 09:00:00 +0530
tags: [machine-learning, data-engineering]
description: One sentence used in post lists and meta tags.
---

Your first paragraph. Use `##` for section headings — the title above is
rendered separately, so never use `#` in the body.
```

Tags are free-form: use lowercase and hyphens. Any new tag automatically gets its own
section and anchor on **/tags/** — there is nothing else to register.

## Writing a post from handwritten notes

Handwritten notes are photographed and turned into posts through a WhatsApp
integration with the Hermes agent, which transcribes them, drafts the post in your
voice with suggested tags, and publishes it once you approve.

---

## Local preview

The system Ruby on macOS (2.6) is too old for current `github-pages`/Jekyll. The
committed `Gemfile` is already pinned to older, Ruby 2.6-compatible gem versions
(`jekyll ~> 3.9`, `ffi ~> 1.15.5`, `google-protobuf ~> 3.21.0`), so this works
out of the box:

```bash
bundle install --path vendor/bundle
bundle exec jekyll serve
```

If you upgrade to a modern Ruby (`brew install ruby` → 3.x), you can switch the
Gemfile back to plain `gem "github-pages", group: :jekyll_plugins`, which tracks
whatever Jekyll/plugin versions GitHub Pages actually runs in production.

## Layout

```
_layouts/      default, post, page
_includes/     header, footer, post-list-item
_posts/        the blog posts
assets/        main.scss (all styling), site.js (theme toggle)
tags.html      auto-generated tag index — no maintenance needed
```

Styling is one file, `assets/css/main.scss`, driven by CSS custom properties at the
top. Light and dark palettes are the two token blocks — change a colour there and it
propagates everywhere.
