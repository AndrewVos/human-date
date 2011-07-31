human-date
==========

Installation:
-------------

```
gem install human-date
```

Usage:
------

```ruby
require 'human-date'

translator = HumanDate::DateTranslator.new
date1 = DateTime.parse "2011-10-23T00:00:00"
date2 = DateTime.parse "2012-12-25T02:05:10"

translator.translate(date1, date2)
#=> 1 year, 2 months, 4 days, 2 hours, 5 minutes and 10 seconds

translator.translate(date2, date1)
#=> 1 year, 2 months, 4 days, 2 hours, 5 minutes and 10 seconds ago

translator.parts = [:year, :month, :day]
translator.translate(date1, date2)
#=> 1 year, 2 months and 4 days
```
