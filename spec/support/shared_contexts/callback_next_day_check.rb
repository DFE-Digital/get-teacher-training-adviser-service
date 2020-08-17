RSpec.shared_context 'callback_next_day_check' do
  let(:options) do
    { Date.today.strftime("%a %d %B") => [
      ["todays times and dates"], ["some more todays times and dates"]
      ],
      Date.tomorrow.strftime("%a %d %B") => [
        ["tomorrows times and dates"], ["some more tomorrows times and dates"]
      ]
    }
  end
  let(:options_hash) { described_class.next_day_check(options) }
end