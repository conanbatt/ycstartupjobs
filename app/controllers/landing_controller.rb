class LandingController < ApplicationController

  def index
    @jobs = JobOpening.includes(:company).first(20)
  end

  def search
    query = params[:q]
    @jobs = if(query.blank?)
      JobOpening.includes(:company).first(20)
    else
      @jobs = JobOpening.search(query)
      @jobs.preload(:company)
    end

    render template: "landing/_jobs", locals: { jobs: @jobs }, layout: false
  end
end
