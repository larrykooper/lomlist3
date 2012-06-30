class PagesController < ApplicationController
   before_filter :authenticate_user!
   
   def display 
     if request.fullpath == '/help'
       render 'help/index'
     end    
   end
   
end   