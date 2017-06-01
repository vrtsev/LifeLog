describe Publications::Users::CommentsController, type: :controller do
  let(:user)     { create :user }
  let(:pub_post) { create :publication_post, user: user }

  describe 'GET #new' do
    render_views
    subject { get :new, params: { user_id: user, post_id: pub_post } }

    context 'when user signed in' do
      before { sign_in user }

      it { expect(subject).to render_template(:new) }
      it { expect(subject).to have_http_status(:success) }
    end
  end

  describe 'POST #create' do
    before { sign_in user }

    subject do
      post :create, params: {
        user_id: user,
        post_id: pub_post,
        comment: comment_params
      }
    end

    context 'with valid attributes' do
      let(:comment_params) { attributes_for(:publication_comment) }

      it 'saves the new comment in the database' do
        expect { subject }.to change(Publication::Comment, :count).by(1)
      end

      it 'redirects to the home page' do
        expect(subject).to redirect_to user_post_path(user, pub_post)
      end
    end

    context 'with invalid attributes' do
      let(:comment_params) do
        attributes_for(:publication_comment, content: 'a')
      end

      it 'does not save the new comment in the database' do
        expect { subject }.not_to change(Publication::Comment, :count)
      end

      it 're-renders the :new template' do
        expect(subject).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    let(:comment) { create :publication_comment, post: pub_post, user: user }
    before { sign_in user }

    subject do
      get :edit, params: { user_id: user, post_id: pub_post, id: comment }
    end

    it { expect(subject).to render_template(:edit) }
    it { expect(subject).to have_http_status(:success) }
  end

  describe 'PATCH #update' do
    let(:comment) { create :publication_comment, user: user, post: pub_post }

    before do
      sign_in user
      patch :update, params: {
        user_id: user.id,
        post_id: pub_post.id,
        id:      comment.id,
        comment: comment_params
      }
    end

    context 'valid attributes' do
      let(:comment_params) do
        attributes_for(:publication_comment, content: 'new content')
      end

      it 'changes @post attributes' do
        expect(comment.reload.content).to eq('new content')
      end

      it 'redirects to the updated post' do
        expect(response).to redirect_to user_post_path(user, pub_post)
      end
    end

    context 'invalid attributes' do
      let(:comment_params) do
        attributes_for(:publication_comment, content: 'a')
      end

      it 'does not change @post attributes' do
        expect { response }.not_to change(comment.reload, :content)
      end

      it 're-renders the edit method' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment) { create :publication_comment, user: user, post: pub_post }
    before         { sign_in user }

    subject do
      delete :destroy, params: {
        user_id: user.id,
        post_id: pub_post.id,
        id:      comment.id
      }
    end

    it 'deletes the post' do
      expect { subject }.to change(Publication::Comment, :count).by(-1)
    end

    it 'redirects to post #index' do
      subject
      expect(response).to redirect_to user_post_path(user, pub_post)
    end
  end
end
