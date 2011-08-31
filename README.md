Pivot Table
===========

A handy tool for transforming a dataset into a spreadsheet-style pivot table.

Why make this?
--------------

One of the most powerful and underrated features of spreadhseet packages is their ability to create pivot tables. I'm often asked
to replicate this functionality in a web application...

Installation
------------

Couldn't be easier...

    gem install pivot_table

There are no dependencies and pivot will work on any version of Ruby.

Usage
-----

At the very least, you will need to provide four things to create a pivot table...

* a dataset (this doesn't necessarily have to be an ActiveRecord dataset, but it should at least behave like ActiveRecord e.g. OpenStruct)
* the method to be used as column names
* the method to be used as row names
* the method to be used as the pivot

Let's say you have a dataset that looks like this (I'll use OpenStruct, but this could easily be ActiveRecord, or even a custom object):

    my_data = []
    my_data << OpenStruct.new(:city => 'London',   :quarter => 'Q1', :sales => 100)
    my_data << OpenStruct.new(:city => 'London',   :quarter => 'Q2', :sales => 200)
    my_data << OpenStruct.new(:city => 'London',   :quarter => 'Q3', :sales => 300)
    my_data << OpenStruct.new(:city => 'London',   :quarter => 'Q4', :sales => 400)
    my_data << OpenStruct.new(:city => 'New York', :quarter => 'Q1', :sales => 10)
    my_data << OpenStruct.new(:city => 'New York', :quarter => 'Q2', :sales => 20)
    my_data << OpenStruct.new(:city => 'New York', :quarter => 'Q3', :sales => 30)
    my_data << OpenStruct.new(:city => 'New York', :quarter => 'Q4', :sales => 40)

You can then generate a pivot table like so...

    p = PivotTable::Table.new do |p|
      p.data     = my_data
      p.column   = :quarter
      p.row      = :city
      p.pivot_on = :sales
    end
    p.generate

...which will give you a hash that looks like this...

    {
      :headers => ['', 'Q1', 'Q2', 'Q3', 'Q4', 'Total'],
      :rows => [
        ['London',  100, 200, 300, 400, 1000],
        ['New York', 10,  20,  30,  40, 100]
      ],
      :totals => ['Total', 110, 220, 330, 440, 1100]
    }

...which makes it easy-peasy to print a pivot table that looks like this...

               Q1    Q2    Q3    Q4   Total
    London    100   200   300   400    1000
    New York   10    20    30    40     100
    Total     110   220   330   440    1100

Ah, that's better.

Still to come
-------------

PivotTable is still in the very early stages of development. As my personal needs for evolve, I'll update the gem with new functionality accordingly.
Feel free to fork and/or suggest new features.

Ruby 1.9 only...
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