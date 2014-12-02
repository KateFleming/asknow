class Tag < ActiveRecord::Base
  # Validations
  validates :name, presence: true
  # Relationships
  has_and_belongs_to_many :questions
  
  # Processes a list of keywords
  def self.process_all(keywords)
    if keywords
      tags = []
      
      # Split the keywords and loop through each on
      keywords.split(",").each do |keyword|
        tags << self.new(name: keyword).find_or_add
      end
      
      # Return an array of tags
      tags
    end
  end
  
  # Checks if a tag exists, if not, add it
  def find_or_add
    if name
      n = name.strip.downcase
      tag = Tag.find_by(name: n) || Tag.create(name: n)
    end
  end
end
