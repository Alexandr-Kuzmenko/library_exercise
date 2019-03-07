RSpec.shared_examples 'index examples' do |assigned_resource, resource_class|
  it { expect(subject.status).to eq 200 }
  it { expect(subject).to have_http_status :success }
  it { expect(subject).to render_template :index }
  # it { expect(assigns(assigned_resource)).to match(resource_class.all) }
end
