class ApplicationOlapRecord < ActiveRecord::Base
  self.abstract_class = true
  connects_to database: { writing: :olap, reading: :olap }
end