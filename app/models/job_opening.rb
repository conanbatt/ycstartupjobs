class JobOpening < ApplicationRecord
  belongs_to :company

  include PgSearch
   pg_search_scope :search,
    associated_against: {
      company: [:name]
    },
    against: [:title, :location, :team], using: {
      tsearch: {:prefix => true},
      trigram: {},
      dmetaphone: {}
    }
end
