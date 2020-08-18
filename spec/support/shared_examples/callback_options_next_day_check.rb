RSpec.shared_examples "callback_options_remove_current_day" do
  it "removes todays data" do
    expect(options_hash.size).to eq(1)
    expect(options_hash.keys).to eq([Date.tomorrow.strftime("%a %d %B")])
  end
end
