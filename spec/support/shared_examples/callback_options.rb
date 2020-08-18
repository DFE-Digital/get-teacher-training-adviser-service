RSpec.shared_examples "callback_options" do
  it "returns a Hash of Arrays with DateTimes" do
    expect(options_hash).to be_a(Hash)
    expect(options_hash.first[1][0][1]).to be_a(DateTime)
  end
end
