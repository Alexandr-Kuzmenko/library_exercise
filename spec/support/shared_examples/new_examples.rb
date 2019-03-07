RSpec.shared_examples 'new examples' do
  it { expect(subject.status).to eq 200 }
  it { expect(subject).to have_http_status :success }
  it { expect(subject).to render_template :new }
end