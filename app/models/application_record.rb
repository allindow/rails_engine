class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.random
    find(rand(0..self.count))
  end
end
