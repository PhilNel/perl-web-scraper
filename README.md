# perl-web-scraper

A modular and extensible scraping framework written in Perl. This project uses clean architecture principles, with pluggable components for input (providers), processing (parsers), and output (sinks).

It is designed to be both locally testable and cloud-deployable (e.g., on AWS Lambda), with the ability to fetch, parse, and store job listings or other structured content from web sources.

## 🛠 Installation

All dependencies are vendored locally. You do not need to install system-wide Perl modules.

To reset and reinstall:

```bash
make clean install
```

This installs all required dependencies into `./local` based on the `cpanfile`.

## 📦 Requirements
This project depends on a Node.js-based renderer to fetch the HTML for parsing.
Make sure the `node-web-fetcher project` is available and has run to produce rendered.html.

## 🧪 Usage

Run the full flow:

```perl
perl main.pl
```

Or use `make`:
```make
make parse
```

## 🔧 Dependencies

- Moo — Lightweight object system for clean OOP
- Mojo::DOM — HTML parsing
- Carp — Better error reporting
- Role::Tiny — Composable interface-style roles for enforcing structure across components
