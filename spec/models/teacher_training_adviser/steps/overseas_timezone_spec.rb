require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::OverseasTimezone do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { expect(described_class).to be TeacherTrainingAdviser::Steps::OverseasTimezone }

  context "attributes" do
    it { is_expected.to respond_to :time_zone }
    it { is_expected.to respond_to :telephone }
  end

  context "time_zone" do
    it { is_expected.to_not allow_values("", nil).for :time_zone }
    it { is_expected.to allow_values(ActiveSupport::TimeZone.all).for :time_zone }
  end

  describe "#skipped?" do
    it "returns false if degree_options is equivalent and uk_or_overseas is overseas" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]
      wizardstore["returning_to_teaching"] = false
      expect(subject).to_not be_skipped
    end

    it "returns true if degree_options is not equivalent" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]
      wizardstore["returning_to_teaching"] = false
      expect(subject).to be_skipped
    end

    it "returns true if uk_or_overseas is not overseas" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      wizardstore["returning_to_teaching"] = false
      expect(subject).to be_skipped
    end

    it "returns true if returning_to_teaching is true" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      wizardstore["returning_to_teaching"] = true
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }
    before do
      instance.time_zone = "London"
      instance.telephone = "1234567"
    end
    it {
      is_expected.to eq({
        "time_zone" => "London",
        "telephone" => "1234567",
      })
    }
  end

  describe "#filtered_time_zones" do
    subject { instance.filtered_time_zones }
    it "removes 'International Date Line West' value from ActiveSupport::TimeZones" do
      expect(subject.map(&:name)).to eq(["American Samoa", "Midway Island", "Hawaii", "Alaska", "Pacific Time (US & Canada)", "Tijuana", "Arizona", "Chihuahua", "Mazatlan", "Mountain Time (US & Canada)", "Central America", "Central Time (US & Canada)", "Guadalajara", "Mexico City", "Monterrey", "Saskatchewan", "Bogota", "Eastern Time (US & Canada)", "Indiana (East)", "Lima", "Quito", "Atlantic Time (Canada)", "Caracas", "Georgetown", "La Paz", "Puerto Rico", "Santiago", "Newfoundland", "Brasilia", "Buenos Aires", "Greenland", "Montevideo", "Mid-Atlantic", "Azores", "Cape Verde Is.", "Casablanca", "Dublin", "Edinburgh", "Lisbon", "London", "Monrovia", "UTC", "Amsterdam", "Belgrade", "Berlin", "Bern", "Bratislava", "Brussels", "Budapest", "Copenhagen", "Ljubljana", "Madrid", "Paris", "Prague", "Rome", "Sarajevo", "Skopje", "Stockholm", "Vienna", "Warsaw", "West Central Africa", "Zagreb", "Zurich", "Athens", "Bucharest", "Cairo", "Harare", "Helsinki", "Jerusalem", "Kaliningrad", "Kyiv", "Pretoria", "Riga", "Sofia", "Tallinn", "Vilnius", "Baghdad", "Istanbul", "Kuwait", "Minsk", "Moscow", "Nairobi", "Riyadh", "St. Petersburg", "Tehran", "Abu Dhabi", "Baku", "Muscat", "Samara", "Tbilisi", "Volgograd", "Yerevan", "Kabul", "Ekaterinburg", "Islamabad", "Karachi", "Tashkent", "Chennai", "Kolkata", "Mumbai", "New Delhi", "Sri Jayawardenepura", "Kathmandu", "Almaty", "Astana", "Dhaka", "Urumqi", "Rangoon", "Bangkok", "Hanoi", "Jakarta", "Krasnoyarsk", "Novosibirsk", "Beijing", "Chongqing", "Hong Kong", "Irkutsk", "Kuala Lumpur", "Perth", "Singapore", "Taipei", "Ulaanbaatar", "Osaka", "Sapporo", "Seoul", "Tokyo", "Yakutsk", "Adelaide", "Darwin", "Brisbane", "Canberra", "Guam", "Hobart", "Melbourne", "Port Moresby", "Sydney", "Vladivostok", "Magadan", "New Caledonia", "Solomon Is.", "Srednekolymsk", "Auckland", "Fiji", "Kamchatka", "Marshall Is.", "Wellington", "Chatham Is.", "Nuku'alofa", "Samoa", "Tokelau Is."])
    end
  end
end
