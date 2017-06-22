class LandingController < ApplicationController

  def index
    @jobs = JobOpening.joins(:company).distinct.includes(:company)
    @jobs_count = @jobs.count
  end

  def search
    query = params[:q]
    tags = params[:tags] || []
    company_exclusions = params[:companies] || []

    relation = JobOpening.where.not(company_id: company_exclusions)
    @jobs = if(query.present? && tags.present?)
      relation.search(query).search_exact(tags)
    elsif query.present? && !tags.present?
      relation.search(query)
    elsif tags.present?
      relation.search_exact(tags)
    else
      relation.joins(:company).distinct.includes(:company)
    end

    @jobs.preload(:company)
    @jobs_count = @jobs.count

    render template: "landing/_jobs", locals: {  jobs_count: @jobs_count, jobs: @jobs }, layout: false
  end
end
