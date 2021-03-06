class ItemsController < ApplicationController
   before_filter :authenticate_user!
  
  # POST /items
  # POST /items.json 
  def create
    @item = Item.new(params[:item])
    @item.user = current_user
    @item.create_date = Time.local(params[:create_date][:year],params[:create_date][:month],params[:create_date][:day],12,15,1)
    @item.item_desc = params[:larrytext]
    if @item.save
      @item.tag_with_manually(params[:tag_list], current_user)
      flash[:notice] = 'Item  ' + @item.number.to_s + ' was successfully created.'
      redirect_to :action => 'show', :number => @item.number
    else
      @tags_to_display = params[:tag_list]
      render :action => 'new'
    end
  end
 
  # DELETE /items/{number}
  # DELETE /items/{number}.json
  def destroy    
    number_wanted = params[:number_to_delete] ? params[:number_to_delete] : params[:number] 
    @item = current_user.items.find_by_number(number_wanted)       
    if @item
      number_deleted = @item.number
      @item.taggings.each(&:destroy)
      @item.destroy
      flash[:notice] = 'Item ' + number_deleted.to_s + ' was successfully deleted.'
    else
      flash[:notice] = 'That item does not exist.'
    end
    redirect_to items_url     
  end  
  
  # GET /items/{number}/edit
  def edit   
    number_wanted = params[:number_to_edit] ? params[:number_to_edit] : params[:number] 
    @item = current_user.items.find_by_number(number_wanted)
    if @item
      @lastitem = @item     
      @tags_to_display = @item.tag_string
    else 
      flash[:notice] = 'That item does not exist.'
      redirect_to :action => 'index'
    end
  end  
  
  def find_tagfld
    session[:tagfld] ||= Tagfld.new  
  end
  
  # List all items:
  # GET /
  # GET /items
  # GET /items.json

  # List items with tag "foo":
  # GET /tags/foo/items 
  # GET /tags/foo/items.json
  def index
    if tag_name = params[:tagname]
      @items = Item.find_tagged_with(tag_name, current_user).sort
      @page_header = "Listing items with tag: " + tag_name
    else
      @items = current_user.items.order("number")
      @page_header = "Listing all items"
    end    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end     
  end
  
  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new   
    @item.create_date = current_user.new_item_date
    @tags_to_display = ""
  end
  
  # Get LO number of "new next item"
  # POST /items/new-next 
  # POST /items/next-number.json
  def new_next
    @item = Item.new_next(current_user)
    @item.create_date = current_user.new_item_date
    @tags_to_display = ""   
  end
  
  def printview
    @items = current_user.items.order("number") 
  end
  
  def search 
    mysearch = "%" + params[:q] + "%"
    @items = Item.find(:all, 
      :conditions => ["item_desc LIKE ? AND user_id = ?", mysearch, current_user.id], 
      :order => "number")   
      render :action => 'index'
  end 
  
  def search_by_act_type
    @items = current_user.items.where(:act_type => params[:typename]).order("number")
    @page_header = "Listing items with Act type: " + params[:typename]
    render :template => 'items/index'
  end
  
  # GET /items/{number}
  # GET /items/{number}.json
  def show
    @item = Item.find_by_number(params[:number])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # PUT /items/{number}
  # PUT /items/{number}.json
  def update
    @item = Item.find_by_number(params[:number])
    number_updated = @item.number
    @item.update_attributes(params[:item])
    @item.create_date = Time.local(params[:create_date][:year],params[:create_date][:month],params[:create_date][:day],12,15,1)    
    @item.tag_with_manually(params[:tag_list], current_user)
    @item.save
    flash[:notice] = 'Item ' + number_updated.to_s + ' was successfully updated.'
    redirect_to :action => 'show', :number => @item.number
  end

end
