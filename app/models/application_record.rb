class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.random
    offset(rand(0..self.count)).first
  end
end
