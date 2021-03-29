module SpecHelpers
  module ContractHelper
    def mock_unsuccessful_match_back
      expect_any_instance_of(GetIntoTeachingApiClient::CandidatesApi).to \
        receive(:create_candidate_access_token).and_raise(GetIntoTeachingApiClient::ApiError)
    end

    def setup_data
      setup_pick_list_items
      setup_lookup_items
      setup_privacy_policy
    end

    def state
      path = Rails.root.join("spec/contracts/data/state.json")
      JSON.parse(File.open(path).read)
    end

    def setup_pick_list_items
      read_data("pick_list_items").each do |hash|
        items = hash[:values].map { |v| GetIntoTeachingApiClient::PickListItem.new(v) }

        allow_any_instance_of(GetIntoTeachingApiClient::PickListItemsApi).to \
          receive(hash[:method]) { items }
      end
    end

    def setup_lookup_items
      read_data("lookup_items").each do |hash|
        items = hash[:values].map { |v| GetIntoTeachingApiClient::LookupItem.new(v) }

        allow_any_instance_of(GetIntoTeachingApiClient::LookupItemsApi).to \
          receive(hash[:method]) { items }
      end
    end

    def setup_privacy_policy
      path = Rails.root.join("spec/contracts/data/privacy_policy.json")
      policy_data = JSON.parse(File.open(path).read)
      policy = GetIntoTeachingApiClient::PrivacyPolicy.new(policy_data)

      allow_any_instance_of(GetIntoTeachingApiClient::PrivacyPoliciesApi).to \
        receive(:get_latest_privacy_policy) { policy }

      allow_any_instance_of(GetIntoTeachingApiClient::PrivacyPoliciesApi).to \
        receive(:get_privacy_policy).with(policy.id) { policy }
    end

    def read_data(folder)
      path = Rails.root.join("spec/contracts/data/#{folder}/**/*.json")
      Dir[path].map do |data_file|
        {
          method: "get#{data_file.split(folder).last.gsub('/', '_').chomp('.json')}",
          values: JSON.parse(File.open(data_file).read),
        }
      end
    end

    def setup_contract
      expect_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
        receive(:sign_up_teacher_training_adviser_candidate) do |_, request|
          request_json = request.to_json

          unless File.exist?(contract_output_file)
            File.write(contract_output_file, request_json)
          end

          expect(JSON.parse(request_json)).to eq(JSON.parse(File.open(contract_output_file).read))
        end
    end

    def contract_output_file
      filename = RSpec.current_example.metadata[:full_description].parameterize(separator: "_")
      Rails.root.join("spec", "contracts", "output", "#{filename}.json")
    end

    def expect_current_step(step)
      expect(page).to have_current_path(teacher_training_adviser_step_path(step))
    end

    def click_on_continue
      click_on "Continue"
    end

    def new_candidate_identity
      {
        first_name: "John",
        last_name: "Doe",
        email: "john@doe.com",
        existing: false,
      }
    end

    def submit_choice_step(option, step)
      expect_current_step(step)
      choose option
      click_on_continue
    end

    def submit_select_step(option, step)
      expect_current_step(step)
      select option
      click_on_continue
    end

    def submit_identity_step(first_name:, last_name:, email:, existing: false)
      expect_current_step(:identity)

      fill_in "First name", with: first_name
      fill_in "Last name", with: last_name
      fill_in "Email address", with: email

      mock_unsuccessful_match_back unless existing

      click_on_continue
    end

    def submit_date_of_birth_step(date)
      expect_current_step(:date_of_birth)

      fill_in "Day", with: date.day
      fill_in "Month", with: date.month
      fill_in "Year", with: date.year

      click_on_continue
    end

    def submit_uk_address_step(address_line1:, address_line2:, town_city:, postcode:)
      expect_current_step(:uk_address)

      fill_in "Address line 1", with: address_line1
      fill_in "Address line 2 (optional)", with: address_line2
      fill_in "Town or City", with: town_city
      fill_in "Postcode", with: postcode

      click_on_continue
    end

    def submit_previous_teacher_id_step(teacher_id)
      expect_current_step(:previous_teacher_id)

      fill_in "Teacher reference number (optional)", with: teacher_id
      click_on_continue
    end

    def submit_uk_telephone_step(telephone)
      expect_current_step(:uk_telephone)

      fill_in "UK telephone number (optional)", with: telephone
      click_on_continue
    end

    def submit_review_answers_step
      expect_current_step(:review_answers)
      click_on_continue
    end

    def submit_privacy_policy_step
      expect_current_step(:accept_privacy_policy)
      check "Accept the privacy policy"
      click_on "Complete"
    end
  end
end
