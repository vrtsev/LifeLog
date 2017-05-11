describe Publications::TagsController, type: :controller do
  let(:user)       { create :user }
  let!(:user_post) { create :publication_post, user: user }
  let!(:tag)       { create :tag }
  let!(:tagging)   { create :tagging, tag: tag, post: user_post }
  before           { sign_in user }

  describe 'GET #show' do
    subject { get :show, params: { name: tag.name } }

    it { expect(subject).to have_http_status(:success) }
    it { expect(subject).to render_template :show }
  end
end
