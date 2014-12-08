class Member
  def validate_account(account)
    name_presence_validator.validate(account)
    email_presence_validator.validate(account)
    email_uniqueness_validator.validate(account)
    
    # Only validate password if present
    if account.password
      password_presence_validator.validate(account)
      password_confirmation_validator.validate(account)
      password_length_validator.validate(account)
    end
  end
  private
  def name_presence_validator
    @name_validator ||= ActiveModel::Validations::PresenceValidator.new(
          attributes: :name, :class => Account
    )
  end
  def email_presence_validator
    @email_presence_validator ||= ActiveModel::Validations::PresenceValidator.new(
          attributes: :email, :class => Account
    )
  end
  def email_uniqueness_validator
    @email_uniqueness_validator ||= ActiveRecord::Validations::UniquenessValidator.new(
          attributes: :email, :class => Account
    )
  end
  def password_presence_validator
    @password_presence_validator ||= ActiveModel::Validations::PresenceValidator.new(
          attributes: :password, :class => Account
    )
  end
  def password_confirmation_validator
    @password_confirmation_validator ||= ActiveModel::Validations::ConfirmationValidator.new(
          attributes: :password, :class => Account
    )
  end
  def password_length_validator
    @password_length_validator ||= ActiveModel::Validations::LengthValidator.new(
          attributes: :password, :minimum => 5, :class => Account
    )
  end    
end