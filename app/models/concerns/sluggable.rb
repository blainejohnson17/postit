# Using Concerns
module Sluggable
  extend ActiveSupport::Concern

  included do
    after_validation :generate_slug!
    class_attribute :slug_column
  end

  def generate_slug!
    str = to_slug(self.send(self.class.slug_column.to_sym))
    new_str = str
    count = 2
    dash = "-"
    obj = self.class.where(slug: str).first
    while obj && obj != self
      new_str.gsub!(/(.*)(-)(.*)/, str) if count > 2
      new_str = new_str + "-" + count.to_s
      obj = self.class.where(slug: new_str).first
      count += 1
    end
    self.slug = new_str.downcase
  end

  def to_slug(name)
    #strip the string
    ret = name.strip

    #blow away apostrophes
    ret.gsub! /['`]/,""

    # @ --> at, and & --> and
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric with dash
     ret.gsub! /\s*[^A-Za-z0-9]\s*/, '-'

     #convert double dashes to single
     ret.gsub! /-+/,"-"

     #strip off leading/trailing dash
     ret.gsub! /\A[-\.]+|[-\.]+\z/,""

     ret
  end

  def to_param
    self.slug
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end