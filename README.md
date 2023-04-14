[![Ruby](https://img.shields.io/badge/ruby-3.1.2-brightgreen.svg)](https://www.ruby-lang.org/en/news/2022/04/12/ruby-3-1-2-released/)

This repo contains Ruby program which converts a given amount from one currency to another one, using an
external API - https://www.exchangerate-api.com/

Given from_currency, amount and to_currency we expect to receive the converted_amount.
## How to install
You need to have Ruby 3.1.2 installed to run this program on your machine, after this download this repo and run:

 `bundle install`
## How to use
Program expects the following command-line options:

- `-f`, --from_currency FROM_CURRENCY (required): the base currency for the exchange rate.
- `-a`, --amount AMOUNT (required): the amount to be exchanged.
- `-t`, --to_currency TO_CURRENCY (required): the currency to which to convert.

All currencies must follow [ISO 4217 Three Letter Currency Codes format](https://www.exchangerate-api.com/docs/supported-currencies)(not case sensitive).

## Example Usage
```
➜ ✗ ./bin/converter -f USD -a 100 -t PLN
420.43
```

#### Note
spec examples are co-authored with ChatGPT
