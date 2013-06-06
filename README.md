Pivot Table  [![Build Status](https://secure.travis-ci.org/edjames/pivot_table.png)](http://travis-ci.org/edjames/pivot_table)
===========

A handy tool for transforming a dataset into a spreadsheet-style pivot table.

Why make this?
--------------

One of the most powerful and underrated features of spreadhseet packages is their ability to create pivot tables. I'm often asked
to replicate this functionality in a web application, so I decided to share. This is a simple gem for a specific job, I hope it helps.

Installation
------------

Couldn't be easier...

    gem install pivot_table

There are no dependencies and pivot *should* work on any version of Ruby.

Usage
-----

At the very least, you will need to provide three things to create a pivot table...

* a dataset (this doesn't necessarily have to be an ActiveRecord dataset, but it should at least behave like ActiveRecord e.g. OpenStruct)
* the method to be used as column names
* the method to be used as row names

Let's say you have a collection of Order objects that looks like this:

    obj_1 = Order.new(:city => 'London',   :quarter => 'Q1')
    obj_2 = Order.new(:city => 'London',   :quarter => 'Q2')
    obj_3 = Order.new(:city => 'London',   :quarter => 'Q3')
    obj_4 = Order.new(:city => 'London',   :quarter => 'Q4')
    obj_5 = Order.new(:city => 'New York', :quarter => 'Q1')
    obj_6 = Order.new(:city => 'New York', :quarter => 'Q2')
    obj_7 = Order.new(:city => 'New York', :quarter => 'Q3')
    obj_8 = Order.new(:city => 'New York', :quarter => 'Q4')

    data = [ obj_1, obj_2, obj_3, obj_4, obj_5, obj_6, obj_7, obj_8 ]

Instantiate a new PivotTable::Grid object like this...

    grid = PivotTable::Grid.new do |g|
      g.source_data   = data
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

    g.rows[0].header => 'London'
    g.rows[0].data   => [obj_1, obj_2, obj_3, obj_4]

    g.rows[1].header => 'New York'
    g.rows[1].data   => [obj_5, obj_6, obj_7, obj_8]

    g.column_headers => ['Q1', 'Q2', 'Q3', 'Q4']
    g.columns.length => 4

    g.columns[0].header => 'Q1'
    g.columns[0].data   => [obj_1, obj_5]

    g.columns[1].header => 'Q2'
    g.columns[1].data   => [obj_2, obj_6]

    g.columns[2].header => 'Q3'
    g.columns[2].data   => [obj_3, obj_7]

    g.columns[3].header => 'Q4'
    g.columns[3].data   => [obj_4, obj_8]

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

Still to come
-------------

PivotTable is still in the very early stages of development. As my personal needs for evolve, I'll update the gem with new functionality accordingly.
Feel free to fork and/or suggest new features.

Ruby 1.9 only...for now
----------------

Right now PivotTable only supports Ruby 1.9. If you need support for 1.8 please feel free to fork and merge. I will not however be adding
support for 1.8.

Contributing to PivotTable
---------------------

If you want to contribute:

* Check out the latest master to make sure the feature hasn’t been implemented or the bug hasn’t been fixed yet
* Check out the issue tracker to make sure someone already hasn’t requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don’t break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history.

Copyright
---------

Copyright (c) 2011 Ed James. See LICENSE for details.
