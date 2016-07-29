class Donation < ActiveRecord::Base
  has_one :donor
  belongs_to :inventory


	def self.to_csv
		CSV.generate do |csv|
			csv << column_names.insert(-11, "Number Remaining")
			all.each do |donation|
				 @missioninv = MissionInventory.where(lot_number:  donation.lot_number, item_description: donation.item_description)
				    subtractor = 0
				    if @missioninv.nil?	
				        subtractor = 0
					else
				      @missioninv.each do |x|
				          subtractor = subtractor + x.quantity 
				      end
				    end	
				    if donation.quantity.nil?
						csv << donation.attributes.values_at(*column_names)
					else
						csv << donation.attributes.values_at(*column_names).insert(-12, donation.quantity - subtractor)
					end

			end
		end
	end
	def self.search(search)
	  if search
	    where('item_description LIKE ? or brand LIKE ? or category LIKE ? or location LIKE ? or details LIKE ? or ref LIKE ? or comments LIKE ? or country_of_origin LIKE ? or lot_number LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
	  else
	    all()
	   end
	end
end
