RSpec.shared_examples 'edit examples' do
  it { expect(subject.status).to eq 200 }
  it { expect(subject).to have_http_status :success }
  it { expect(subject).to render_template :edit }
end