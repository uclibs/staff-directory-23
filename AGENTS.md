# Staff Directory — Agent Guide

Small custom Ruby on Rails app (Rails 8.1, RSpec, RuboCop, Shakapacker/Webpack,
Devise + Shibboleth SSO) deployed to the library `libapps` server via Capistrano.
Node 24 (`.nvmrc`); MySQL in production, SQLite in test.

## Project rules

Detailed, always-current guidance lives in `.cursor/rules/`:

- `code-review-checklist.mdc` — what to check when reviewing code (incl. keeping
  comments and the README current on every review).
- `code-change-standards.mdc` — RuboCop + RSpec must pass, coverage must hold or
  rise, favor unit specs, never silence RuboCop unless told to that request.
- `dependency-management.mdc` — how to update and verify gems/JS packages.
- `migration-safety.mdc` — keep migrations reversible and non-destructive.
- `no-push-without-explicit-request.mdc` — the user handles pushing.
- `pr-body-markdown-format.mdc` — PR body output format.
