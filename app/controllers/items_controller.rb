class ItemsController < ApplicationController
   before_filter :authenticate_user!
  
  # POST /items
  # POST /items.json 
  def create
    @item = Item.new(params[:item])
    @item.create_date =    Time.local(params[:create_date][:year],params[:create_date][:month],params[:create_date][:day],12,15,1)    
    @item.item_desc = params[:larrytext]
    @item.tag_with_manually(params[:tag_list])
    if @item.save
      flash[:notice] = 'Item  ' + @item.number.to_s + ' was successfully created.'
      redirect_to :action => 'show', :id => @item.id
    else
      render :action => 'new'
    end
  end
 
  # DELETE /items/1
  def destroy    
    if params[:number]
      idwanted = Item.where(:number => params[:number]).first.id
    else    
      idwanted = params[:id]
    end    
    @item = Item.find(idwanted)
    number_deleted = @item.number
    @item.destroy   
    flash[:notice] = 'Item ' + number_deleted.to_s + ' was successfully deleted.'
    redirect_to items_url     
  end  
  
  # GET /items/1/edit
  def edit       
    if params[:number]
      item_to_edit = Item.find_by_number(params[:number])
      if item_to_edit  
        idwanted = item_to_edit.id  
      else 
        idwanted = nil 
      end
    end
    if idwanted 
      @item = item_to_edit
      @lastitem = @item
      @tagfld = find_tagfld
      @tagfld.empty!
    else 
      flash[:notice] = 'That item does not exist.'
      redirect_to :action => 'index'
    end
  end  
  
  def find_tagfld
    session[:tagfld] ||= Tagfld.new  
  end
  
  # GET /items
  # GET /items.json
  def index
    if tag_name = params[:tagname]
      @items = Item.find_tagged_with(tag_name).sort
      @page_header = "Listing items with tag: " + tag_name
    else
      @items = Item.order("number")
      @page_header = "Listing all items"
    end    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end     
  end
  
  def mungetags 
    @thetags = Item.tags
  end    
  
  # GET /items/new
  # GET /items/new.json
  def new     
    @lastitem = Item.find(:first, :order => "id DESC")
    @item = Item.new
    @tagfld = find_tagfld
    @tagfld.empty!    
  end
  
  def new_next 
    @lastitem = Item.find(:first, :order => "id DESC")
    @item = Item.new_next
    @tagfld = find_tagfld
    @tagfld.empty!
  end
  
  def printview
    @items = Item.order("number") 
  end
  
  def search 
    mysearch = "%" + params[:q] + "%"
    @items = Item.find(:all, 
      :conditions => ["item_desc LIKE ?", mysearch], 
      :order => "number")   
      render :action => 'index'
  end 
  
  def search_by_act_type
    @items = Item.where(:act_type => params[:typename]).order("number")
    @page_header = "Listing items with Act type: " + params[:typename]
    render :template => 'items/index'
  end
  
  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find_by_number(params[:number])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find_by_number(params[:number])
    number_updated = @item.number
    @item.update_attributes(params[:item])
    @item.create_date = Time.local(params[:create_date][:year],params[:create_date][:month],params[:create_date][:day],12,15,1)    
    @item.tag_with_manually(params[:tag_list])
    @item.save
    flash[:notice] = 'Item ' + number_updated.to_s + ' was successfully updated.'
    redirect_to :action => 'show', :number => @item.number
  end

end
