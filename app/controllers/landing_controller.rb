class LandingController < ApplicationController

  def index
    @jobs = JobOpening.joins(:company).distinct.includes(:company)
    @jobs_count = @jobs.count
  end

  def search
    query = params[:q]
    tags = params[:tags] || []

    @jobs = if(query.present? && tags.present?)
      JobOpening.search(query).search_exact(tags)
    elsif query.present? && !tags.present?
      JobOpening.search(query)
    elsif tags.present?
      JobOpening.search_exact(tags)
    else
      JobOpening.joins(:company).distinct.includes(:company)
    end

    @jobs.preload(:company)
    @jobs_count = @jobs.count

    render template: "landing/_jobs", locals: {  jobs_count: @jobs_count, jobs: @jobs }, layout: false
  end
end
