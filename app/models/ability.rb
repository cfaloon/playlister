class Ability
  include CanCan::Ability

  def initialize(user)
    # everyone can read everything
    can :read, :all

    # further permissions defined IF a user was provided
    if user.present?
      can :update, Playlist, user_id: user.id
    end
  end
end
