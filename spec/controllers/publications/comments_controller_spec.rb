describe Publications::CommentsController, type: :controller do
  let(:user)              { create :user }
  let!(:publication_post) { create :publication_post, user: user }
  let!(:post_comment) do
    create :publication_comment,
           post: publication_post,
           user: user
  end
  before { sign_in user }

  describe 'GET #new' do
    before { get :new, params: { post_id: publication_post.id } }

    it { expect(response).to have_http_status(:success) }
    it { expect(response).to render_template :new }
  end

  describe 'POST #create' do
    subject do
      post :create,
           params: { post_id: publication_post.id, comment: comment_params }
    end

    context 'with valid attributes' do
      let(:comment_params) { attributes_for(:publication_comment) }

      it 'saves the new post in the database' do
        expect { subject }.to change(Publication::Comment, :count).by(1)
      end

      it 'redirects to the home page' do
        expect(subject).to redirect_to post_path(publication_post.id)
      end
    end

    context 'with invalid attributes' do
      let(:comment_params) do
        attributes_for(:publication_comment, content: 'a')
      end

      it 'does not save the new post in the database' do
        expect { subject }.not_to change(Publication::Comment, :count)
      end

      it 're-renders the :new template' do
        expect(subject).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before do
      patch :update, params: {
        id: post_comment.id,
        post_id: publication_post.id,
        comment: comment_params
      }
    end

    context 'valid attributes' do
      let(:comment_params) do
        attributes_for(:publication_comment, content: 'new content')
      end

      it 'changes @post attributes' do
        expect(post_comment.reload.content).to eq('new content')
      end

      it 'redirects to the updated post' do
        expect(response).to redirect_to post_path(publication_post.id)
      end
    end

    context 'invalid attributes' do
      let(:comment_params) do
        attributes_for(:publication_comment, content: 'a')
      end

      it 'does not change @post attributes' do
        expect { response }.not_to change(post_comment.reload, :content)
      end

      it 're-renders the edit method' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    subject do
      delete :destroy, params: {
        id: post_comment.id,
        post_id: publication_post.id
      }
    end

    it 'deletes the post' do
      expect { subject }.to change(Publication::Comment, :count).by(-1)
    end

    it 'redirects to post #index' do
      subject
      expect(response).to redirect_to post_path(publication_post.id)
    end
  end
end
