RSpec.shared_examples "policy_views" do
  it "returns a success response" do
    expect(subject).to have_http_status(200)
  end

  it "includes the policy text" do
    expect(subject.body).to include(policy.text)
  end
end
