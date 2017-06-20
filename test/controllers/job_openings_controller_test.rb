require 'test_helper'

class JobOpeningsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_opening = job_openings(:one)
  end

  test "should get index" do
    get job_openings_url
    assert_response :success
  end

  test "should get new" do
    get new_job_opening_url
    assert_response :success
  end

  test "should create job_opening" do
    assert_difference('JobOpening.count') do
      post job_openings_url, params: { job_opening: { commitment: @job_opening.commitment, description: @job_opening.description, locations: @job_opening.locations, salary: @job_opening.salary, team: @job_opening.team, title: @job_opening.title } }
    end

    assert_redirected_to job_opening_url(JobOpening.last)
  end

  test "should show job_opening" do
    get job_opening_url(@job_opening)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_opening_url(@job_opening)
    assert_response :success
  end

  test "should update job_opening" do
    patch job_opening_url(@job_opening), params: { job_opening: { commitment: @job_opening.commitment, description: @job_opening.description, locations: @job_opening.locations, salary: @job_opening.salary, team: @job_opening.team, title: @job_opening.title } }
    assert_redirected_to job_opening_url(@job_opening)
  end

  test "should destroy job_opening" do
    assert_difference('JobOpening.count', -1) do
      delete job_opening_url(@job_opening)
    end

    assert_redirected_to job_openings_url
  end
end
