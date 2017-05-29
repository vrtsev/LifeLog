describe Publications::Users::CategoriesController, type: :controller do
  let(:user)      { create :user }
  let(:category)  { create :publication_category, user: user }

  describe 'GET #show' do
    before { get :show, params: { user_id: user, id: category } }

    it { expect(response).to render_template(:show) }
    it { expect(response).to have_http_status(:success) }
  end
end
