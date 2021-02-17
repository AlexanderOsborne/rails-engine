class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.select_records(params)
    results = (params[:per_page] || 20).to_i
    skipped_pages = [params[:page].to_i, 1].max - 1
    limit(results).offset(results * skipped_pages)
  end

  def self.search(query)
    where('LOWER(name) LIKE ?', "%#{query.downcase}%").order(:name)
  end
end
