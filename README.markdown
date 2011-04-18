# Bodhi
**A straightforward DSL for generating and reporting on simple metrics in Ruby.**

Bodhi helps you generate simple, straightforward reporting metrics for your Rails application. You
can generate reports for anything that can be expressed as a value over time with a simple API.

## Installation

### Rails 3

Add the following to your Gemfile, and run `bundle install`

     gem 'bodhi'

After installing Bodhi, run the following generator and run `rake db:migrate`. This will create
a table where Bodhi can store past metric values.

## Basic Usage

### Definining Metrics

Using Bodhi is as simple as definining what metrics you would like to use in `/initializers/bodhi.rb`. 
Bodhi provides several helpers to cover common metrics that you may want to to track.

#### Counting

     Metric.count :dogs            # Counts the total number of the 'dogs' model
     Metric.count :dogs, :new      # Counts all new instances of the 'dogs' model
     Metric.count :dogs, :updated  # Counts all updated instances of the 'dogs' model

#### Aggregating by column

     Metric.average :dogs, :num_puppies  # Calculates the average number of puppies for a given dog
     Metric.sum :dogs, :num_puppies      # Calculates the total number of puppies.
     Metric.minimum :dogs, :num_puppies  # Calculates the minimum puppy count for any dog
     Metric.maximum :dogs, :num_puppies  # Calculates the maximum puppy count for any dog


#### Custom Metrics

If you need more sophisticated functionality than what the provided helpers define, you can define
custom metrics using Metric.define. Just specify a block that returns a float value. A hash will
be passed to your block that specifies start and end times of your metric run in a block.

     Metric.define :percentage_with_puppies do |run|
       relevant_dogs = Dog.where("created_at between ? and ?", run[:start], run[:end])

       total_count = relevant_dogs.count
       puppy_count = relevant_dogs.where("num_puppies > 0").count
       total_count == 0 ? 0 : total_count / puppy_count
     end

### Using Metrics

Metrics can be accessed by passing the name of the metric to the Metric class, like so:

     m = Metric[:percentage_with_puppies]

At any time, you can get the current value of a metric (from the beginning of the current date to now) by calling
`current` on a metric:

     Metric[:percentage_with_puppies].current

You can access historical values by calling `for_period` for a given metric:

     m = Metric[:percentage_with_puppies]
     m.for_period 1.month.ago, Time.now

If the second parameter is omitted on `for_period`, the current date is assumed.

#### Generating Metrics

You can generate metrics (run metrics up to the current date), by calling `generate` on a particular Metric, 
or all metrics with Metric.generate_all

    Metric[:percentage_with_puppies].generate
    Metric.generate_all

This will store metric values to the database. You'll need to add calls to generate_all to something that
runs at a scheduled interval (like a cron rake task), to ensure metrics are generated correctly. Don't worry
about the frequency of your runs, Bodhi won't generate duplicate metrics and will backfill any missing metrics.

### TODO

* Support for blocks passed to helper functions
* Support for parameterized metrics (or metric groups?)
* Support for Mongoid or non-ActiveRecord environments

### Contributing

Feel free to fork and make any changes necessary. If you'd like to contribute back, I'd appreciate a topic
branch and relevant tests.

