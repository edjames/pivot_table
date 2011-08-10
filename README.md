Pivot
=====

A handy tool for transforming a dataset into a spreadsheet-style pivot table.

Why make this?
--------------

One of the most powerful and underrated features of spreadhseet packages is their ability to create pivot tables. I'm often asked
to replicate this functionality in a web application...

Installation
------------

Couldn't be easier...

> gem install pivot

There are no dependencies and pivot will work on any version of Ruby.

Usage
-----

At the very least, you will need to provide four things to create a pivot table...

* a dataset (this doens't necessarily have to be an ActiveRecord dataset, but it should at least behave like ActiveRecord e.g. OpenStruct)
* the method to be used as column names
* the method to be used as row names
* the method to be used as the pivot

You can then generate a pivot table like so...



Contributing to Pivot
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