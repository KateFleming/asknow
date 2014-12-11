class Ability
  include CanCan::Ability

  def initialize(account)
    
    # Define abilities for admin, member, and guest
    
    account ||= Account.new(account_type: 'guest') # guest user (not logged in)
    
    if account.admin?
      # An admin can do anything
      can :manage, :all
    elsif account.member?
      # Members can manage their own accounts
      can :manage, Account do |_account|
        account == _account
      end
      
      # Members can manage their own feeds
      can :manage, Feed do |feed|
        account.owns?(feed)
      end
      
      # Members can view any other questions
      can [:view, :create], Question
      
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
      
      # Members can manage their votes
      can :manage, Vote do |vote|
        account.owns?(vote)
      end
      
      # Members can join groups
      can :join, Group
    elsif account.guest?
      # Guests can manage their own accounts
      can :manage, Account do |_account|
        account == _account
      end
      
      # Guests can manage their own feeds
      can :manage, Feed do |feed|
        account.owns?(feed)
      end
      
      # Guests can view and post any other questions
      can [:view, :create], Question
      
      # Guests can view any answer
      can :view, Answer
      
      # Guests can manage their own answers
      can :manage, Answer do |answer|
        account.owns?(answer)
      end
      
      # Guests can manage their votes
      can :manage, Vote do |vote|
        account.owns?(vote)
      end
    else
      # If they're anything else, don't let them do anything
      cannot :manage, :all
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
