## Who Controls It

This is a proof-of-concept Beneficial Ownership register to demonstrate how data could be collected. It was designed in less than a couple of days by OpenCorporates to help inform UK Civil Society's response to the  [UK government's consultation](https://www.gov.uk/government/uploads/system/uploads/attachment_data/file/367578/bis-14-1145-the-register-of-people-with-significant-control-psc-register-register-final-1.pdf) on what the Beneficial Ownership register (or register of Persons of Significant Control) will look like. Beneficial owners are the individuals who ultimately control companies, together with the means/route of control. For more information is

We will be iterating and improving it over time, and believe it can be developed into an open data global beneficial ownership database. Before then there's a lot to do, but first here's the site in a nutshell:

* Allows company owners to self-submit that they control companies, using [OpenCorporates API](https://api.opencorporates.com/) to search for the companies
* Allow third-parties to add BO data for companies they add based on official filings
* Allows evidentiary filings to be uploaded (uses S3)
* List companies added, and allow to be searched by 'live-search'
* Show control graphs on controlling persons page
* Pulls in data on the company from the OpenCorporates
* Deployed to alpha.WhoControlsIt.com using dummy data


### Think you can improve **Who Controls it**? Here's how
This software is open-source, and we welcome contributors to improve it, both on the back-end and on the UI too. The application is coded in [Ruby On Rails](http://rubyonrails.org/), but there is plenty to help with, even if you aren't a Ruby coder (front end development, documentation, etc)

#### Requirements for running in development: ====
* Ruby 2.1.2
* MySQL (we may change to use sqlite)


####Installing on your local development machine:
    git clone https://github.com/openc/WhoControlsIt.git
	cd whocontrolsit
	bundle
	bundle exec rake db:migrate
	rails s #to start a server, accessible at localhost:3000

This README would normally document whatever steps are necessary to get the
application up and running.

####Things that need adding:
* Design
* Write test suite (rspec)
* Add relationships for other types of control
* Add more complex networks (bi-furcated etc)
* Make UI smoother, more ajaxy/sexy

