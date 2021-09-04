class Merchant < ApplicationRecord
  has_many :items

  def self.search(query)
    where('lower(name) like ?', "%#{query.downcase}%").order(:name).first
  end
end
