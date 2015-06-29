class Donation < ActiveRecord::Base
  has_one :donor
  belongs_to :inventory
end
