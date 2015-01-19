# Pivot Table  [![Build Status](https://secure.travis-ci.org/edjames/pivot_table.png)](http://travis-ci.org/edjames/pivot_table) [![Code Climate](https://codeclimate.com/github/edjames/pivot_table.png)](https://codeclimate.com/github/edjames/pivot_table) [![Dependency Status](https://gemnasium.com/edjames/pivot_table.png)](https://gemnasium.com/edjames/pivot_table) [![Gem Version](https://badge.fury.io/rb/pivot_table.png)](http://badge.fury.io/rb/pivot_table) [![pivot_table API Documentation](https://www.omniref.com/ruby/gems/pivot_table.png)](https://www.omniref.com/ruby/gems/pivot_table)

A handy tool for transforming a dataset into a spreadsheet-style pivot table.

### Why make this?

One of the most powerful and underrated features of spreadhseet packages is their ability to create pivot tables. I'm often asked
to replicate this functionality in a web application, so I decided to share. This is a simple gem for a specific job, I hope it helps.

### Installation

Couldn't be easier...

    gem install pivot_table

### Usage

At the very least, you will need to provide three things to create a pivot table...

* a dataset (this doesn't necessarily have to be an ActiveRecord dataset, but it should at least behave like ActiveRecord e.g. OpenStruct)
* the method to be used as column names
* the method to be used as row names

Let's say you have a collection of Order objects that looks like this:

    obj_1 = Order.new(city: 'London',   quarter: 'Q1')
    obj_2 = Order.new(city: 'London',   quarter: 'Q2')
    obj_3 = Order.new(city: 'London',   quarter: 'Q3')
    obj_4 = Order.new(city: 'London',   quarter: 'Q4')
    obj_5 = Order.new(city: 'New York', quarter: 'Q1')
    obj_6 = Order.new(city: 'New York', quarter: 'Q2')
    obj_7 = Order.new(city: 'New York', quarter: 'Q3')
    obj_8 = Order.new(city: 'New York', quarter: 'Q4')

    data = [ obj_1, obj_2, obj_3, obj_4, obj_5, obj_6, obj_7, obj_8 ]

Instantiate a new PivotTable::Grid object like this...

    g = PivotTable::Grid.new do |g|
      g.source_data  = data
      g.column_name  = :quarter
      g.row_name     = :city
      g.value_name   = :sales
    end


The `value_name` parameter is only required if you want to access totals;
the others are required.

All you have to do now is build the grid...

    g.build

This will give you a logical grid (represented by an two-dimensional array) which can be likened to this table:

    --------------------------------------------
    |          |  Q1   |  Q2   |  Q3   |  Q4   |
    |----------|--------------------------------
    | London   | obj_1 | obj_2 | obj_3 | obj_4 |
    | New York | obj_5 | obj_6 | obj_7 | obj_8 |
    --------------------------------------------

Then you have the following aspects of the pivot table grid available to you...

    g.row_headers => ['London', 'New York']
    g.rows.length => 2

    g.rows[0].header            => 'London'
    g.rows[0].data              => [obj_1, obj_2, obj_3, obj_4]
    g.rows[0].column_data('Q2') => obj_2

    g.rows[1].header            => 'New York'
    g.rows[1].data              => [obj_5, obj_6, obj_7, obj_8]
    g.rows[1].column_data('Q2') => obj_6

    g.column_headers => ['Q1', 'Q2', 'Q3', 'Q4']
    g.columns.length => 4

    g.columns[0].header             => 'Q1'
    g.columns[0].data               => [obj_1, obj_5]
    g.columns[0].row_data('London') => obj_1

    g.columns[1].header             => 'Q2'
    g.columns[1].data               => [obj_2, obj_6]
    g.columns[1].row_data('London') => obj_2

    g.columns[2].header             => 'Q3'
    g.columns[2].data               => [obj_3, obj_7]
    g.columns[2].row_data('London') => obj_3

    g.columns[3].header             => 'Q4'
    g.columns[3].data               => [obj_4, obj_8]
    g.columns[3].row_data('London') => obj_4

The API should give you a lot of flexibility with regards to rendering this information in your views.
E.g. The rows and columns collections make it very easy to produce horizontal, vertical and overall total values.

Ah, that's better.

If you want to get the totals for rows, columns, or the entire grid, you can pass a `value_name` as shown above, and then query the Grid like this:

    g.column_totals
    g.columns[0].total
    g.columns[1].total
    g.columns[2].total
    g.row_totals
    g.rows[0].total
    g.rows[1].total
    g.grand_total

#### Configuration Options

You can also provide additional configuration options when instantiating your Grid. Options are provided as a hash e.g.

    g = PivotTable::Grid.new(:sort => true) do |g|
      g.source_data  = data
      g.column_name  = :quarter
      g.row_name     = :city
      g.value_name   = :sales
    end

Here are the available configuration options:

###### 1. Sort

**Usage:** `sort: false`

**Default:** `true`

This option will automatically sort your data alphabetically based on your column and row headers. If you disable sorting your original data ordering will be preserved.


### Ruby Support

* 1.9.3
* 2.x

### Contributing to PivotTable

If you want to contribute:

* Check out the latest master to make sure the feature hasn’t been implemented or the bug hasn’t been fixed yet
* Check out the issue tracker to make sure someone already hasn’t requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don’t break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history.

### Copyright

Copyright (c) 2014 Ed James. See LICENSE for details.
