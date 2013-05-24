class Category < ActiveRecord::Base
  attr_accessible :name, :priority
  has_many :todos

  validates :name, :presence => true
  validates :priority, :presence => true, :numericality => true
end
