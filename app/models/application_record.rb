class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def previous
    Blog.where("id < ?", self.id).order("id DESC").first
  end
  
  def next
    Blog.where("id > ?", self.id).order("id ASC").first
  end
end
