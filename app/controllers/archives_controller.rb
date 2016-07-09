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
  def search(pattern, flag = false)
    r = []
    if pattern[0] == '#'
        if pattern[1] == 'r'
            if pattern[2] == ':'
                 return search(pattern[3, pattern.length], true)
            end
        end 
    end
    pt = pattern.upcase
    gx = Regexp.new(pt)
    Post.find_each do |e|
       if flag
          r << e if e.title.upcase =~ gx 
        else
          r << e if e.title.upcase.include? pt
        end      
    end
    return r
  end
end
