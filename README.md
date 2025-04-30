# perl-web-scraper

A modular and extensible scraping framework written in Perl. This project uses clean architecture principles, with pluggable components for input (providers), processing (parsers), and output (sinks).

It is designed to be both locally testable and cloud-deployable (e.g., on AWS Lambda), with the ability to fetch, parse, and store job listings or other structured content from web sources.

This component pairs with [node-web-fetcher](https://github.com/PhilNel/node-web-fetcher).

## 🛠 Installation

Run the following command to install all required Perl modules into a local directory (local/lib/perl5):

```bash
make install
```

This uses `cpanm` to install the modules defined in the `cpanfile` without polluting the global Perl environment.

This installs all required dependencies into `./local` based on the `cpanfile`.

## 📦 Requirements
This project depends on a Node.js-based renderer to fetch the HTML for parsing.
Make sure the `node-web-fetcher project` is available and has run to produce rendered.html.

## 🧪 Usage

Run the full flow:

```make
make parse
```

## 🔧 Dependencies

Runtime:
- Moo — Lightweight object system for clean OOP
- Mojo::DOM — HTML parsing
- JSON — JSON encoding
- Role::Tiny — Composable interface-style roles for enforcing structure across components
- Amazon::S3 — For fetching the scraped HTML that must be parsed
- Log::Log4perl — Application logs

Dev only:
- Dotenv — Locads local environment variables
- Perl::Critic — For linting the project source code