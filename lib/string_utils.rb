module StringUtils
  def self.slugify(str)
    str.strip.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/^-|-$/, '')
  end
end
