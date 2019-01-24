class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # for pagination purpose
  def self.page(page_number = nil, per_page = nil)
    page_no = page_number.to_i
    page_no = page_no.positive? ? page_no : 1
    per_page = per_page.to_i
    per_page = per_page.positive? ? per_page : 50
    skip = (page_no - 1) * per_page
    offset(skip).limit(per_page)
  end
end
