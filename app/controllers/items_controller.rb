class ItemsController < ApplicationController
   before_filter :authenticate_user!
  
  # GET /items
  # GET /items.json
  def index
    list 
    render :action => 'list' 
    
  end
  
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
    if params[:nbrtodelete]     
      idwanted = Item.where(:number => params[:nbrtodelete]).first.id  
    else    
      idwanted = params[:id]
    end    
    @item = Item.find(idwanted)
    @item.destroy   
    redirect_to items_url     
  end  
  
  # GET /items/1/edit
  def edit       
    if params[:nbrtoedit]     
      idwanted = Item.where(:number => params[:nbrtoedit]).first.id  
    else    
      idwanted = params[:id]
    end  
    @item = Item.find(idwanted) 
    @lastitem = @item
    @tagfld = find_tagfld
    @tagfld.empty!
  end  
  
  def find_tagfld
    session[:tagfld] ||= Tagfld.new  
  end
  
  def list	
  	@items =
  	  if tag_name = params[:tagname]
        Item.find_tagged_with(tag_name).sort			
  	  else
  		  Item.order("number")
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
  
  def search 
    mysearch = "%" + params[:q] + "%"
    @items = Item.find(:all, 
      :conditions => ["item_desc LIKE ?", mysearch], 
      :order => "number")   
      render :action => 'list'
  end 
  
  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
   	@item = Item.find(params[:id])
	  @item.update_attributes(params[:item])
    @item.create_date = Time.local(params[:create_date][:year],params[:create_date][:month],params[:create_date][:day],12,15,1)    
	  @item.tag_with_manually(params[:tag_list])
	  @item.save
    flash[:notice] = 'Item was successfully updated.'
    redirect_to :action => 'show', :id => @item		   
  end

end
