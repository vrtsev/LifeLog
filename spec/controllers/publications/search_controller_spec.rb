describe Publications::SearchController do
  let(:user)  { create :user }
  let(:query) { 'example' }
  before      { sign_in user }

  describe 'GET #index' do
    before { get :index, params: { query: query } }

    it { expect(response).to render_template(:index) }
    it { expect(response).to have_http_status(:success) }
  end
end
