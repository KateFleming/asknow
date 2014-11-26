class Feed < ActiveRecord::Base
  # Validations
  validates :tag, uniqueness: true, allow_nil: true
  validate :one_primary_per_account
  
  # Relationships
  belongs_to :account
  has_many :question_banks, dependent: :destroy
  
  def self.filter_by_page(page, items)
    # Pagination
    if page
      @page = page
    else
      @page = 1
    end
    
    items_per_page = 18
    starting = items_per_page * (@page.to_i - 1)
    {
      items: items.slice(starting, items_per_page),
      current_page: @page,
      total_pages: (items.count.to_f / items_per_page.to_f).ceil
    }
  end
  
  # Validation
  # Each account can only have one primary feed
  def one_primary_per_account
    if Feed.where(account: account, primary: true).count > 1
      errors.add(:tag, "can't have more than one primary feed")
    end
  end
end
