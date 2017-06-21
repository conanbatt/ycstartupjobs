class JobOpening < ApplicationRecord
  belongs_to :company

  include PgSearch
   pg_search_scope :search, against: [:title, :location], using: [:tsearch, :trigram, :dmetaphone]
end
