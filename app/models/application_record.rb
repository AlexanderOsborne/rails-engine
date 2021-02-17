class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.select_records(params)
    results = (params[:per_page] || 20).to_i
    skipped_pages = [params[:page].to_i, 1].max - 1
    limit(results).offset(results * skipped_pages)
  end

  def self.search(query)
    where('LOWER(name) LIKE ?', "%#{query.downcase}%")
  end

  def self.by_price(min_price, max_price)
    where('unit_price BETWEEN ? AND ?', (min_price || 0), (max_price || Float::INFINITY))
  end
end
