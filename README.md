# taskmapper-unfuddle

TaskMapper provider for Unfuddle.

## Usage

Instantiate the TaskMapper instance

    unfuddle = TaskMapper.new(:unfuddle, :username => "user", :password => "p4ss!", :account => 'unfud')

if this gives you trouble when trying to access projects or tickets, you can set the protocol explicitly. By default,
as of version 0.4.0, the protocol is 'https'. Some older projects may need to set to 'http'.

    unfuddle = TaskMapper.new(:unfuddle, :username => "user", :password => "p4ss!", :account => 'unfud', :protocol => 'http')
    
## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 [Hybrid Group](http://hybridgroup.com). See LICENSE for details.
