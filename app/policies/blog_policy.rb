class BlogPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    true
  end

  def new?
    create?
  end

  def create?
    true
  end

  def show?
    @current_user.admin? or @current_user == @user
  end

  def edit?
    update?
  end

  def update?
    @current_user.admin? or @current_user == @user
  end

  def destroy?
    return false if @current_user == @user
    update?
  end

end
