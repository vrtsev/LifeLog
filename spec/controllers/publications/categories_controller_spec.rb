describe Publications::CategoriesController, type: :controller do
  let(:user)      { create :user }
  let!(:category) { create :publication_category, user: user }
  before          { sign_in user }

  describe 'GET #show' do
    before { get :show, params: { id: category } }

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
      post :create,
           params: { category: category_params }
    end

    context 'with valid attributes' do
      let(:category_params) { attributes_for(:publication_category) }

      it 'saves the new category in the database' do
        expect { subject }.to change(Publication::Category, :count).by(1)
      end

      it 'redirects to the home page' do
        expect(subject).to redirect_to category_path(Publication::Category.last)
      end
    end

    context 'with invalid attributes' do
      let(:category_params) { attributes_for(:publication_category, :invalid) }

      it 'does not save the new category in the database' do
        expect { subject }.not_to change(Publication::Category, :count)
      end

      it 're-renders the :new template' do
        expect(subject).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before do
      patch :update,
            params: { id: category.id, category: category_params }
    end

    context 'valid attributes' do
      let(:category_params) do
        attributes_for \
          :publication_category,
          title: 'Edited',
          description: 'new description'
      end

      it 'changes @category attributes' do
        expect(category.reload.title).to eq('Edited')
        expect(category.reload.description).to eq('new description')
      end

      it 'redirects to the updated category' do
        expect(response).to redirect_to category_path(category.id)
      end
    end

    context 'invalid attributes' do
      let(:category_params) do
        attributes_for \
          :publication_category,
          title: nil,
          description: 'a'
      end

      it 'does not change @category attributes' do
        expect { response }.not_to change(category.reload, :title)
        expect { response }.not_to change(category.reload, :description)
      end

      it 're-renders the edit method' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: category.id } }

    it 'deletes the category' do
      expect { subject }.to change(Publication::Category, :count)
    end

    it 'redirects to category #index' do
      subject
      expect(response).to redirect_to posts_path
    end
  end
end
