class BasesController < ApplicationController
  
  def index
    
  end
  
  private
   
   def base_params
     params.require(:base).permit(:base_name, base_number, :base_kind)
   end
end
