class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is? 'admin'
      can :manage, User
    else
      can :read, User
    end
  end
end
