require "rails_helper"

RSpec.describe WhatDegreeClassHelper, type: :helper do
  let(:class_options) { GetIntoTeachingApiClient::TypesApi.new.get_qualification_uk_degree_grades }

  describe "#remove_third_and_pass_unknown" do
    it "removes third class and pass unknown values" do
      result = remove_third_and_grade_unknown(class_options)
      expect(result.map { |x| x.value }).to eq(["Not applicable", "First class", "2:1", "2:2"])
    end
  end
end
