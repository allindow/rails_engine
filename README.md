# Rails Engine README

## Contributors
* [Matt Campbell](https://github.com/matthewecampbell)
* [Angela Lindow](https://github.com/allindow)

## About
Rails Engine is an API built to simulate business analytics.  The database (postgres) stores customers, merchants, items, invoices, invoice items and transactions.  You can send requests to different endpoints to receive different sets of data.  For example, you could sent a GET request to:

```
/api/v1/merchants
```
and it will return all of the merchants in the database using JSON:

``` json
[
  {
    "id":1,
    "name":"Schroeder-Jerde"
  },
  {
    "id":2,
    "name":"Klein, Rempel and Jones"
  },
  {
    "id":3,
    "name":"Willms and Sons"
  }
]
```

Also, you could hit an endpoint like

```
GET /api/v1/merchants/:id/favorite_customer
```
which will return the best customer for an individual merchant.


## Rails Engine Setup Instructions

To clone this repository, use this command in your terminal:
```
git clone https://github.com/allindow/rails_engine.git
```
Bundle once inside of the Rails Engine directory.
```
bundle
```
Setup the database.
```
rails db:create db:migrate
```
Seed the database with CSV data using a rake task.
```
rake import_csv:create_all
```
Run the test suite using Rspec.
```
rspec
```
You can also run the spec harness privded by [Turing School](https://github.com/turingschool) by switching into the spec harness directory from the project root directory
```
cd rales_engine_spec_harness
```
and running
```
rake
```

#### All available endpoints can be found in the '''config/routes.rb``` or the original project spec for [Rails Engine](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/rails_engine.md).
