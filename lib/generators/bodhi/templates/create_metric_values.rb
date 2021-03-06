class CreateMetricValues < ActiveRecord::Migration
  def self.up
    create_table :metric_values do |t|
      t.string :metric
      t.datetime :start
      t.datetime :end
      t.float :value
      
    end
    add_index :metric_values, [:metric, :start], :unique => true, :name => 'index_metric_values_on_metric_and_start'
  end
  
  def self.down
    drop_table :metric_values
  end
end