ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :metric_values do |t|
    t.string :metric
    t.datetime :start
    t.datetime :end
    t.float :value
  end

  create_table :dogs do |m|
    m.timestamps
    m.string :name
    m.string :breed
    m.integer :num_puppies
  end
end

class Dog < ActiveRecord::Base
end

Dog.create!(:name => 'Sparky', :breed => 'Rotweiller', :num_puppies => 10, :created_at => 1.month.ago, :updated_at => 1.month.ago)
Dog.create!(:name => 'Bowser', :breed => 'Pug', :num_puppies => 6, :created_at => 1.week.ago)
Dog.create!(:name => 'Rex', :breed => 'Pug', :num_puppies => 2)