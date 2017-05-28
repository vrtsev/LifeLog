describe Publications::Users::PostsController, type: :controller do
  let(:user)      { create :user }
  let(:user_post) { create :publication_post, user: user }

  describe 'GET #index' do
    before { get :index, params: { user_id: user } }

    it { expect(response).to render_template(:index) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #show' do
    before { get :show, params: { user_id: user, id: user_post } }

    it { expect(response).to render_template(:show) }
    it { expect(response).to have_http_status(:success) }
  end
end
