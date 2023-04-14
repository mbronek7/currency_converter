[![Ruby](https://img.shields.io/badge/ruby-3.1.2-brightgreen.svg)](https://www.ruby-lang.org/en/news/2022/04/12/ruby-3-1-2-released/)

Ruby program which converts a given amount from one currency to another one, using an
external API - https://open.er-api.com/v6/latest/{currency}


Given from_currency, amount and to_currency we expect to receive the converted_amount.


## How to use
Program expects the following command-line options:

- `-f`, --from_currency FROM_CURRENCY (required): the base currency for the exchange rate.
- `-a`, --amount AMOUNT (required): the amount to be exchanged.
- `-t`, --to_currency TO_CURRENCY (required): the currency to which to convert.
