class Inventory < ActiveRecord::Base
  has_and_belongs_to_many :missions
  has_many :donations
end
