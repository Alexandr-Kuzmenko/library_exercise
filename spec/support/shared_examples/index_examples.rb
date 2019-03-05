RSpec.shared_examples 'index examples' do |assigned_resource, resource_class|
  it { expect(subject).to respond_with(:ok) }
  it { expect(subject).to render_template(:index) }
  it { expect(assigns(assigned_resource)).to match(resource_class.all) }
end
