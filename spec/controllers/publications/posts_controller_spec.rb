describe Publications::PostsController, type: :controller do
  let!(:user)      { create :user }
  let!(:blog_post) { create :blog_post, user: user }
  before           { sign_in user }
  # TODO: take care to include check of assigment category to post
  # let(:category) { create :category, user: user }

  describe 'GET #index' do
    before { get :index }

    it { expect(response).to render_template(:index) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #show' do
    before { get :show, params: { id: blog_post.id } }

    it { expect(response).to render_template(:show) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET #new' do
    before { get :new }

    it { expect(response).to render_template(:new) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST #create' do
    let(:post_title)   { 'Test post' }
    let(:post_content) { 'Some content' }
    let(:post_params) do
      {
        content: post_content,
        pinned: true,
        visible: true,
        commenting: true,
        # TODO: take care to include check of assigment category to post
        category_id: 1
      }
    end

    context 'when post is valid' do
      let(:valid_params) { post_params.merge(title: post_title) }
      before             { post :create, params: { post: valid_params } }

      it 'redirects to created post' do
        expect(response).to redirect_to post_path \
          Publications::BlogPost.last.id
      end
      it { expect(response).to have_http_status(302) }

      it 'creates new post in db' do
        expect { post :create, params: { post: valid_params } }
          .to change(Publications::BlogPost, :count).by(1)
      end

      it 'assigns author to post' do
        expect(assigns(:post).user_id).to eq(user.id)
      end
    end

    context 'when post is invalid' do
      it { expect(response).to have_http_status(200) }
      it 'does not save post' do
        expect { response }.not_to change(Publications::BlogPost, :count)
      end
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: blog_post.id } }

    it { expect(response).to render_template(:edit) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'PATCH #update' do
    # TODO: take care to include category to post object
    let(:new_title)   { 'NewPost' }
    let(:new_content) { 'Some text' }
    # TODO: take care to include check of assigment category to post
    # let(:category)     {}
    # let(:new_category) {}
    let(:post_params) do
      {
        title: new_title,
        content: new_content,
        supplemented: true,
        pinned: true,
        visible: false,
        # TODO: take care to include check of assigment category to post
        commenting: false
      }
    end
    before { patch :update, params: { id: blog_post.id, post: post_params } }

    it 'changes post attributes' do
      expect(blog_post.reload.title).to eq(new_title)
      expect(blog_post.content).to      eq(new_content)
      expect(blog_post.supplemented).to eq(true)
      expect(blog_post.pinned).to       eq(true)
      expect(blog_post.visible).to      eq(false)
      expect(blog_post.commenting).to   eq(false)
    end

    it 'does not change user of post' do
      expect(blog_post.user.id).to eq(user.id)
    end

    it 'does not change posts count' do
      expect { response }.not_to change(Publications::BlogPost, :count)
      expect { response }.not_to change(Post, :count)
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: blog_post.id } }

    it 'deletes post from db' do
      expect { subject }.to change(Publications::BlogPost, :count).by(-1)
    end
  end
end
