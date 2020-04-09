class BasesController < ApplicationController
  
  def index
    @bases = Base.all
  end
  
  def edit
    @base = User.find(params[:id])
  end
  
  def new
    @base = Base.new
    
  end
  
  def create
    @base = Base.new(base_params)
    if @base.save
      flash[:success] = "新規拠点の作成に成功しました。"
      redirect_to user_bases_url
    else
      render :new
    end
  end
  
  private
   
   def base_params
     params.require(:base).permit(:base_name, :base_number, :base_kind)
   end
end
