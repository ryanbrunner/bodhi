# Model examples in ActiveRecord

# This file describes common operations on ActiveRecord
# models.

class Dog < ActiveRecord::Base
  attr_accessible :breed, :num_puppies
end

module Bodhi

  # gives count of dogs
  Metric.count :dogs

  Metric.count :dogs, :new

  Metric.count :dogs, :updated

  Metric.count :dogs do
    where(:breed => "Rotweiller")
  end

  Metric.sum :dogs, :num_puppies

  Metric.average :dogs, :num_puppies

  Metric.largest :dogs, :num_puppies
  
  # You can also include blocks in any of the 
  # aggregators, they will limit the results
  # before the aggregation occurs.
  Metric.smallest :dogs, :num_puppies do
    where(:breed => "Pug")
  end

  Metric.count :dogs, :date => :learned_sit_at

  Metric.define :some_random_metric do |run|
    # Insert any code in here you like that calculates
    # a float.

    # Run contains start time and end time of the
    # comparison period.


  end

  Metric.compare :dogs, :cats, :difference

  Metric.compare :dogs, :cats, :percentage_difference

end