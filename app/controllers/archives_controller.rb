class ArchivesController < ApplicationController
  def index
    if params[:search_text]
        p = params[:search_text]
        sp = search p
        @posts = Post.where(:id => sp).page(params[:page])
    else
        @posts = Post.order(created_at: :desc).page(params[:page])
    end
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
                #render :text => '系统错误，请重试'
                return true
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
    pt = nil
    gx = nil
    pt = pattern.upcase
    if flag
        begin
           gx = Regexp.new(pt)
        rescue
           redirect_to :action => 'regex_err'
           return
        end
    end
    Post.find_each do |e|
       if flag
          r << e if e.title.upcase =~ gx 
        else
          r << e if e.title.upcase.include? pt
        end      
    end
    return r
  end
  def regex_err
    
  end
end
