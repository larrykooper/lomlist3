
class ActTypesController < ApplicationController
  # GET /act_types
  # GET /act_types.json
  def index
    @act_types = ActType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @act_types }
    end
  end

  # GET /act_types/1
  # GET /act_types/1.json
  def show
    @act_type = ActType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @act_type }
    end
  end

  # GET /act_types/new
  # GET /act_types/new.json
  def new
    @act_type = ActType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @act_type }
    end
  end

  # GET /act_types/1/edit
  def edit
    @act_type = ActType.find(params[:id])
  end

  # POST /act_types
  # POST /act_types.json
  def create
    @act_type = ActType.new(params[:act_type])

    respond_to do |format|
      if @act_type.save
        format.html { redirect_to @act_type, notice: 'Act type was successfully created.' }
        format.json { render json: @act_type, status: :created, location: @act_type }
      else
        format.html { render action: "new" }
        format.json { render json: @act_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /act_types/1
  # PUT /act_types/1.json
  def update
    @act_type = ActType.find(params[:id])

    respond_to do |format|
      if @act_type.update_attributes(params[:act_type])
        format.html { redirect_to @act_type, notice: 'Act type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @act_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /act_types/1
  # DELETE /act_types/1.json
  def destroy
    @act_type = ActType.find(params[:id])
    @act_type.destroy

    respond_to do |format|
      format.html { redirect_to act_types_url }
      format.json { head :no_content }
    end
  end
end
