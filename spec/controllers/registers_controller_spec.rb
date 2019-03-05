require 'rails_helper'

RSpec.describe RegistersController, type: :controller do
  describe 'GET #index' do
    before do
    end
    include_examples 'index examples', :registers, Register.all
  end
end
