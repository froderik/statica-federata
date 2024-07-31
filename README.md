# statica-federata

This is an attempt to build a minimal activity pub implementation intended to be used with static content 
like static web generators or RSS. 

## Dev environment

### Getting started

Ruby needs to be installed. Look at `.ruby-version` to understand what version that is current. I use `rbenv`
in order to run parallel ruby versions at the same time. Then you need bundler probably with:

`gem install bundler`

and then you can

`bundle install`

to get the gems present in `Gemfile.lock` onto you computer.

### Run it locally

The main sinatra file is runnable so try this:

`./statica-federata.rb`

and you should have it up and running on port 4567.
