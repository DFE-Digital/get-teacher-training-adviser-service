require "rails_helper"

RSpec.describe "Redirects from any path", type: :request do

  let(:git_url) { "http://getintoteaching.education.gov.uk/teacher-training-adviser/sign_up/identity?utm_source=adviser-getintoteaching.education.gov.uk&utm_medium=referral&utm_campaign=adviser_redirect"}
  let(:pages) {
    ['/teacher_training_adviser/sign_up/have_a_degree',
    '/teacher_training_adviser/feedbacks/thank_you',
    '/teacher_training_adviser/feedbacks/new',
    '/teacher_training_adviser/sign_up']
  }

  around do |example|
    pages.each do |page|
      @page = page
      example.run
    end
  end

  it "redirects to git url" do
    get @page
    expect(response.code).to eq('301')
    expect(response.location).to eq(git_url)
  end
end
