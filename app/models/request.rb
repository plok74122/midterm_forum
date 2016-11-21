class Request < ApplicationRecord
  validates_presence_of :title
  delegate :name, :to => :category, :prefix => true, :allow_nil => true


  belongs_to :user
  has_many :comments , :dependent => :destroy

  belongs_to :category

end
