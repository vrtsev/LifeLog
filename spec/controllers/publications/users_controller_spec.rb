describe Publications::UsersController, type: :controller do
  let(:user)         { create :user }
  let(:example_user) { create :user }
  before             { sign_in user }

  describe 'GET #index' do
    before { get :index }

    it { expect(response).to render_template(:index) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #show' do
    context 'when shown user is you' do
      before { get :show, params: { id: user } }

      it { expect(response).to redirect_to posts_path }
      it { expect(response).to have_http_status(302) }
    end

    context 'when shown user is not you' do
      before { get :show, params: { id: example_user } }

      it { expect(response).to redirect_to user_posts_path(example_user) }
      it { expect(response).to have_http_status(302) }
    end
  end
end
