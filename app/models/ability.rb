class Ability
  include CanCan::Ability

  def initialize(account)
    # Define abilities for the passed in user here. For example:
    
    account ||= Account.new(account_type: 'guest') # guest user (not logged in)
    
    if account.admin?
      # An admin can do anything
      can :manage, :all
    else
      if account.member?
        # Members can manage their own feeds
        can :manage, Feed do |feed|
          account.owns?(feed)
        end
        
        # Members can view any other questions
        can :view, Question
        
        # Members can manager their own questions
        can :manage, Question do |question|
          account.owns?(question)
        end
        
        # Members can view any answer
        can :view, Answer
        
        # Members can manage their own answers
        can :manage, Answer do |answer|
          account.owns?(answer)
        end
      else
        # Guests can manage their own feeds
        can :manage, Feed do |feed|
          account.owns?(feed)
        end
        
        # Guests can view any other questions
        # can :view, Question
        
        # Guests can view any answer
        can :view, Answer
        
        # Members can manage their own answers
        can :manage, Answer do |answer|
          account.owns?(answer)
        end
      end
    end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
