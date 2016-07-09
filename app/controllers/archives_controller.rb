class ArchivesController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
  end
  def create
    p = params[:search_text]
    if p
         if p == ""
              redirect_to :action => 'index'
         else
             begin
                sp = search p
                @posts = Post.where(:id => sp).page(params[:page])
                render :index
             rescue
                render :text => '系统错误，请重试'
                redirect_to :action => 'index'
             end
         end
    end 
  end
  def search(pattern)
    r = []
    gx = Regexp.new(pattern)
    Post.find_each do |e|
       r << e if e.title =~ gx       
    end
    return r
  end
end
