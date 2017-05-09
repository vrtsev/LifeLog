describe Publications::PostsController, type: :controller do
  let(:user)              { create :user }
  let!(:publication_post) { create :publication_post, user: user }
  before                  { sign_in user }

  describe 'GET #index' do
    before { get :index }

    it { expect(response).to render_template(:index) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #show' do
    before { get :show, params: { id: publication_post } }

    it { expect(response).to have_http_status(:success) }
    it { expect(response).to render_template :show }
  end

  describe 'GET #new' do
    before { get :new }

    it { expect(response).to have_http_status(:success) }
    it { expect(response).to render_template :new }
  end

  describe 'POST #create' do
    subject do
      post :create, params: { post: post_params }
    end

    context 'with valid attributes' do
      let(:post_params) { attributes_for(:publication_post) }

      it 'saves the new post in the database' do
        expect { subject }.to change(Publication::Post, :count).by(1)
      end

      it 'redirects to the home page' do
        expect(subject).to redirect_to post_path(Publication::Post.last)
      end
    end

    context 'with invalid attributes' do
      let(:post_params) { attributes_for(:publication_post, :invalid) }

      it 'does not save the new post in the database' do
        expect { subject }.not_to change(Publication::Post, :count)
      end

      it 're-renders the :new template' do
        expect(subject).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before do
      patch :update,
            params: { id: publication_post.id, post: post_params }
    end

    context 'valid attributes' do
      let(:post_params) do
        attributes_for \
          :publication_post,
          title: 'Edited',
          content: 'new description'
      end

      it 'changes @post attributes' do
        expect(publication_post.reload.title).to eq('Edited')
        expect(publication_post.reload.content).to eq('new description')
      end

      it 'redirects to the updated post' do
        expect(response).to redirect_to post_path(publication_post.id)
      end
    end

    context 'invalid attributes' do
      let(:post_params) do
        attributes_for \
          :publication_post,
          title: nil
      end

      it 'does not change @post attributes' do
        expect { response }.not_to change(publication_post.reload, :title)
      end

      it 're-renders the edit method' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: publication_post.id } }

    it 'deletes the post' do
      expect { subject }.to change(Publication::Post, :count).by(-1)
    end

    it 'redirects to post #index' do
      subject
      expect(response).to redirect_to posts_path
    end
  end
end
