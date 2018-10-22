#  NYTimes Most Populer Articles

This README.md file aims to illuminate in detail the steps required to MostPopular feed of New York Times.

This project is useful for showing most popular feed of  New York Times implemented in Swift 4.2

Build a simple app to hit the NY Times Most Popular Articles API and show a list of articles,
that shows details when items on the list are tapped (a typical master/detail app)

API key has generated through the signup of https://www.nytimes.com/. Implemented MostViewed API using dataTaskWithRequest method in NYTimesAFNetworkingWrapper.swift class. 

Inside the Logs/Test directory, there is coverage report which has extension .xccovreport , and the coverage archive, with extension .xccovarchive respectively. As per man page of this utility “The coverage report contains line coverage percentages for each target, source file, and function/method that has coverage information. The coverage archive contains the raw execution counts for each file in the report”. However,here they are not human readable files that’s the reason we need xccov to look inside these files and display the reports in the nice format.
