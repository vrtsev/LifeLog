describe Publications::Users::VotesController, type: :controller do
  let(:admin)         { create :user }

  let(:user)          { create :user }
  let(:user_post)     { create :publication_post, user: user }
  let(:user_comment) do
    create :publication_comment, user: user, post: user_post
  end

  before { sign_in admin }

  describe 'POST #create' do
    subject do
      post :create, params: {
        user_id: user.id,
        post_id: user_post.id,
        comment_id: user_comment.id
      }
    end

    context 'when user has not voted' do
      it 'saves comment vote to the database' do
        expect { subject }.to change(Publication::Vote, :count).by(1)
      end

      it 'redirects to post page' do
        expect(subject).to redirect_to user_post_path(user, user_post)
      end
    end

    context 'when user alredy voted' do
      let!(:comment_vote) do
        create :publication_vote, user: admin, comment: user_comment
      end

      it 'does not save the new post in the database' do
        expect { subject }.not_to change(Publication::Vote, :count)
      end

      it 're-renders the :new template' do
        expect(subject).to redirect_to user_post_path(user, user_post)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment_vote) do
      create :publication_vote, user: admin, comment: user_comment
    end

    subject do
      delete :destroy, params: {
        user_id: user.id,
        post_id: user_post.id,
        comment_id: user_comment.id,
        id: comment_vote
      }
    end

    it 'deletes the post' do
      expect { subject }.to change(Publication::Vote, :count).by(-1)
    end

    it 'redirects to post #index' do
      subject
      expect(response).to redirect_to user_post_path(user, user_post)
    end
  end
end
