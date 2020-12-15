module TeacherTrainingAdviser::Steps
  class StageOfDegree < Wizard::Step
    extend ApiOptions
    # overwrites session[:sign_up]["degree_status_id"]
    attribute :degree_status_id, :integer

    validates :degree_status_id, pick_list_items: { method: :get_qualification_degree_status }

    def skipped?
      have_a_degree_step = other_step(:have_a_degree)
      studying = have_a_degree_step.degree_options == HaveADegree::DEGREE_OPTIONS[:studying]
      have_a_degree_skipped = have_a_degree_step.skipped?

      have_a_degree_skipped || !studying
    end

    def reviewable_answers
      super.tap do |answers|
        answers["degree_status_id"] = self.class.options.key(degree_status_id)
      end
    end

    def self.options
      generate_api_options(GetIntoTeachingApiClient::PickListItemsApi, :get_qualification_degree_status)
    end
  end
end
