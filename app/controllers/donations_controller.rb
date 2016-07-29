class DonationsController < ApplicationController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]

  # GET /donations
  # GET /donations.json
  def index

    if params[:create_and_add]
   Rails.logger.debug(params.inspect)
    startdate = Date.new((params[:start_date][:year]).to_i,(params[:start_date][:month]).to_i, (params[:start_date][:day]).to_i)
    enddate = Date.new((params[:end_date][:year]).to_i,(params[:end_date][:month]).to_i, (params[:end_date][:day]).to_i)
    @donations = Donation.where("created_at >= :start_date AND created_at <= :end_date",
  {start_date: startdate, end_date: enddate})
        date = DateTime.now.strftime("%m/%d/%Y")
      #prettyDate = date.strftime("%m/%d/%Y")
 respond_to do |format|
      format.html {send_data @donations.to_csv, :filename => "Donations #{date}.csv"}
    end
else
          Rails.logger.debug( params.inspect)
   
      Rails.logger.debug(self.request.format)


    @donations= Donation.search(params[:search]).paginate(:page => params[:page], :per_page => 20)
    respond_to do |format|
      format.html
    end
end



    

   
      # = Donation
  end

  # GET /donations/1
  # GET /donations/1.json
  def show
  end

  # GET /donations/new
  def new
    @donation = Donation.new
    @donor = Donor.all()
    # @donorcities_array = City.all.map { |city| [city.name, city.id] } %>
    Rails.logger.debug(@donor)
  end

  # GET /donations/1/edit
  def edit
    Rails.logger.debug("1111111111111111111111")
    @tempDonations = Donation.find(params[:id])
    # @tempDonor = Donor.find(@tempDonations.donor_id)
    # Rails.logger.debug(@tempDonor)
  end

  # POST /donations
  # POST /donations.json
  def create
    @donation = Donation.new(donation_params)

    # Rails.logger.debug(:id)
Rails.logger.debug(params.inspect)
     if params[:checker] == "1"
       @donation.expiration_date =nil
       Rails.logger.debug("HERE")
     end

    @inventory = Inventory.find_by(item_description: @donation.item_description)

    if @inventory.nil?
      @inventory = Inventory.new
      @inventory.item_description = @donation.item_description
      @donation.inventory_id = @inventory.id
      if @donation.quantity.blank?
        @inventory.quantity = 0
      else
        @inventory.quantity = @donation.quantity
      end
    else
      @inventory.quantity = @inventory.quantity + @donation.quantity
    end
    @inventory.save
    # @donation.donor_id = params[:donor_id]
    # Rails.logger.debug(params[:donor_id].value)
    respond_to do |format|
      if @donation.save
        format.html { redirect_to @donation, notice: 'Donation was successfully created.' }
        format.json { render :show, status: :created, location: @donation }
      else
        format.html { render :new }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /donations/1
  # PATCH/PUT /donations/1.json
  def update
      @oldDonation = Donation.find(params[:id])
      # Rails.logger.debug("11111111111111111111111")
      # Rails.logger.debug(params[:donation][:quantity])
      subtractor = params[:donation][:quantity].to_i - @oldDonation.quantity.to_i


    respond_to do |format|
      if @donation.update(donation_params)
        if params[:checker] == "1"
           @donation.expiration_date =nil
           Rails.logger.debug("HERE")
         end
        @inventory = Inventory.find_by(item_description: @donation.item_description)
        if @inventory.nil? || @inventory.empty?
          @inventory = Inventory.new
          @inventory.item_description = @donation.item_description
          @donation.inventory_id = @inventory.id
          if @donation.quantity.blank?
            @inventory.quantity = 0
          else
            @inventory.quantity = @donation.quantity
          end
        else
         

         @inventory.quantity = @inventory.quantity + subtractor
         Rails.logger.debug("222222222222222")
         Rails.logger.debug(@inventory.quantity)
       end
         @inventory.save

        format.html { redirect_to @donation, notice: 'Donation was successfully updated.' }
        format.json { render :show, status: :ok, location: @donation }
      else
        format.html { render :edit }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donations/1
  # DELETE /donations/1.json
  def destroy
    @donation.destroy
    respond_to do |format|
      format.html { redirect_to donations_url, notice: 'Donation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation
      @donation = Donation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_params
      params.require(:donation).permit(:category, :item_description, :ref, :uom, :location, :country_of_origin, :details, :comments, :brand, :lot_number, :expiration_date, :fair_market_value, :mk_cost, :total_in_kind_value, :donor_id, :quantity, :inventory_id)
    end
end
