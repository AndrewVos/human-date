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
date_translator = HumanDate::DateTranslator.new
from = DateTime.now
sleep 10
to = DateTime.now

date_translator.translate(from, to)
=> '10 seconds'

date_translator.translate(to, from)
=> '10 seconds ago'

date_translator.tolerance = 10
date_translator.translate(from, to)
=> 'now'
```
