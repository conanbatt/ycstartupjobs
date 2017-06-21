class JobOpening < ApplicationRecord

  TECH = %w(ruby javascript python java html css ios android sphinx es6 coffeescript react redux )
  RESPONSIBILITIES = %w(deliver maintain development deploy manage lead design sales mobile collaborate cross-functional)
  FIELDS = %w(machine\ learning infrastructure performance data\ science desktop web mobile frontend backend full\ stack devops design)

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

    pg_search_scope :search_exact,
      against: [:description], using: {
        tsearch: {:prefix => true},
      }
end
