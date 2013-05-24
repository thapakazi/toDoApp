class Todo < ActiveRecord::Base
  attr_accessible :content, :deadline, :status, :title, :user_id
  belongs_to :category

  validates :title, :presence => true
  validates :content, :presence => true
  validates_inclusion_of :status, :in => %w( entered started done dropped failed ),
  						 :message => "extension %{value} is not included in the list of statuses"
end
