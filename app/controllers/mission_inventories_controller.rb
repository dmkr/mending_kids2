class MissionInventoriesController < ApplicationController
  before_action :set_mission_inventory, only: [:show, :edit, :update, :destroy]

  # GET /mission_inventories
  # GET /mission_inventories.json
  def index
    @mission_inventories = MissionInventory.all
  end

  # GET /mission_inventories/1
  # GET /mission_inventories/1.json
  def show
    Rails.logger.debug(params.inspect)
    @inventory = MissionInventory.where(:id => params[:id])
    Rails.logger.debug(@inventory.inspect)
    Rails.logger.debug(@inventory.is_a?(MissionInventory::ActiveRecord_Relation).to_s)
  end

  # GET /mission_inventories/new
  def new
    @donation = Donation.find(params[:inventory_id])
    @inventory = Inventory.find_by(item_description: @donation.item_description)
    @missioninv = MissionInventory.find_by(lot_number: @donation.lot_number)
    
    Rails.logger.debug(@missioninv.inspect)
    Rails.logger.debug(@quantity)
 Rails.logger.debug("!!!!!!!!!!!!!!!!!!!!!!!!")
    # @donation2 = @donation.map { |item| [item.lot_number, item.id] }
    @ary = Array.new 
    
    if !@donation.kind_of?(Array)
        @tempAry = [@donation]
        @quantity = @donation.quantity
         
          Rails.logger.debug(@tempAry)
    else
        @tempAry = @donation
        @donation.each do |quant|
          @quantity = @quantity + quant.quantity
    end


    @quantity = 0
    if @missioninv.nil?
      if !@missioninv.kind_of?(Array)
          @quantity = @quantity- @missioninv.quantity
      else
         @missioninv.each do |quant2|
        @quantity = @quantity - quant2.quantity
      end
        end
      end
     
    end
    @ary = @tempAry.map{|item| [item.lot_number, item.lot_number]}
    
    Rails.logger.debug(@ary)
      @mission_inventory = MissionInventory.new
  end

  # GET /mission_inventories/1/edit
  def edit
     @inventory = MissionInventory.where(:id => params[:id]).first
     @donation = Donation.find(@inventory.id )
     @ary = Array.new 
    
    if !@donation.kind_of?(Array)
        @tempAry = [@donation]
        @quantity = @donation.quantity
         
          Rails.logger.debug(@tempAry)
    else
        @tempAry = @donation
        @donation.each do |quant|
          @quantity = @quantity + quant.quantity
    end


    @quantity = 0
    if @inventory.nil?
      if !@inventory.kind_of?(Array)
          @quantity = @quantity- @inventory.quantity
      else
         @inventory.each do |quant2|
        @quantity = @quantity - quant2.quantity
      end
        end
      end
     
    end
    @ary = @tempAry.map{|item| [item.lot_number, item.lot_number]}
  end

  # POST /mission_inventories
  # POST /mission_inventories.json
  def create
    Rails.logger.debug(mission_inventory_params)
    @mission_inventory = MissionInventory.new(mission_inventory_params)

     @inventory = Inventory.find_by(item_description: @mission_inventory.item_description)



 if params[:checker] == "1"
       @mission_inventory.expiration_date =nil
       Rails.logger.debug("HERE")
     end

    if @inventory.nil?
      @inventory = Inventory.new
      @inventory.item_description = @mission_inventory.item_description
      # @mission_inventory.inventory_id = @inventory.id
      if @mission_inventory.quantity.blank?
        @inventory.quantity = 0
      else
        @inventory.quantity = 0-@mission_inventory.quantity
      end
    else
      @inventory.quantity = @inventory.quantity - @mission_inventory.quantity
    end
    @inventory.save

    respond_to do |format|
      if @mission_inventory.save
        format.html { redirect_to @mission_inventory, notice: 'Mission inventory was successfully created.' }
        format.json { render :show, status: :created, location: @mission_inventory }
      else
        format.html { render :new }
        format.json { render json: @mission_inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mission_inventories/1
  # PATCH/PUT /mission_inventories/1.json
  def update
    @oldDonation = MissionInventory.find(params[:id])
      # Rails.logger.debug("11111111111111111111111")
      # Rails.logger.debug(params[:donation][:quantity])
      subtractor = params[:mission_inventory][:quantity].to_i - @oldDonation.quantity.to_i
    respond_to do |format|
      if @mission_inventory.update(mission_inventory_params)
        inventory = Inventory.find_by(item_description: @@mission_inventory.item_description)
         @inventory.quantity = @inventory.quantity + subtractor
         Rails.logger.debug("222222222222222")
         Rails.logger.debug(@inventory.quantity)
         @inventory.save
        format.html { redirect_to @mission_inventory, notice: 'Mission inventory was successfully updated.' }
        format.json { render :show, status: :ok, location: @mission_inventory }
      else
        format.html { render :edit }
        format.json { render json: @mission_inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mission_inventories/1
  # DELETE /mission_inventories/1.json
  def destroy
    @inventory = Inventory.find_by(item_description: @mission_inventory.item_description)

    @inventory.quantity = @inventory.quantity + @mission_inventory.quantity

    @mission_inventory.destroy
    @inventory.save
    respond_to do |format|
      format.html { redirect_to mission_inventories_url, notice: 'Mission inventory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mission_inventory
      @mission_inventory = MissionInventory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mission_inventory_params
      params.require(:mission_inventory).permit(:item_description, :brand, :lot_number, :mission_id, :quantity, :expiration_date)
    end
end
