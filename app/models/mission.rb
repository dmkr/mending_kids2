class Mission < ActiveRecord::Base
  has_many :mission_inventories
end
