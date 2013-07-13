class Post < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  
  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end
  
  
  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by_name(name) }
    self.tags = new_or_found_tags
  end
  
  validates :title, presence: true,
                             length: { minimum: 5 }
                             
  validates :text, presence: true,
                             length: { minimum: 20 }
                             
end
