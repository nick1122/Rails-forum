class GroupsController < ApplicationController
before_action :find_group , except:[:new , :index , :create,:show , :quit , :join]
before_action :authenticate_user! , only:[:new ]
  def index
  @groups = Group.all
end
  def new
    @group=Group.new
  end

  def create
    @group = current_user.groups.new(group_params)
#@group = Group.create(group_params)
    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
    else
      render :new
    end
  end

def show
 @group = Group.find(params[:id])
  @posts = @group.posts

end
def edit
#  @group=Group.find(params[:id])
end

def update
#  @group = Group.find(params[:id])
  if @group.update(group_params)
    redirect_to groups_path, notice:  "修改討論版成功"

  else
    render :edit
  end
end

def destroy
 # @group = Group.find(params[:id])
  @group.destroy
  redirect_to groups_path , alert: "Success deleted"
end

def join
  @group = Group.find(params[:id])
  if !current_user.is_member_of? (@group)
    current_user.join!(@group)
    flash[:notice] = "Success Join!"
  else
    flash[:warning] = "You've been joined"

  end
#redirect_to group_path(@group)
  redirect_to(:back)
end

def quit
  @group = Group.find(params[:id])

  if current_user.is_member_of?(@group)
    current_user.quit!(@group)
    flash[:alert] = "Success quit!"
  else
    flash[:warning]= "You haven't joined this Group~"

  end

  #redirect_to group_path(@group)
  redirect_to(:back)
end



private
def find_group
  #@group = Group.find(params[:id])
  @group = current_user.groups.find(params[:id])
end
    def group_params
      params.require(:group).permit(:title , :description)
    end

end
