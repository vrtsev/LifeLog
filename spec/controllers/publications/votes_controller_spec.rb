describe Publications::VotesController, type: :controller do
  let(:user)          { create :user }
  let!(:pub_post)     { create :publication_post, user: user }
  let!(:post_comment) do
    create :publication_comment,
           user: user,
           post: pub_post
  end
  before { sign_in user }

  describe 'POST #create' do
    subject do
      post :create, params: {
        post_id: pub_post.id,
        comment_id: post_comment.id
      }
    end

    context 'when user has not voted' do
      it 'saves comment vote to the database' do
        expect { subject }.to change(Publication::Vote, :count).by(1)
      end

      it 'redirects to post page' do
        expect(subject).to redirect_to post_path(pub_post)
      end
    end

    context 'when user alredy voted' do
      let!(:comment_vote) do
        create :publication_vote, user: user, comment: post_comment
      end

      it 'does not save the new post in the database' do
        expect { subject }.not_to change(Publication::Vote, :count)
      end

      it 're-renders the :new template' do
        expect(subject).to redirect_to post_path(pub_post)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment_vote) do
      create :publication_vote, user: user, comment: post_comment
    end

    subject do
      delete :destroy, params: {
        post_id: pub_post.id,
        comment_id: post_comment.id,
        id: comment_vote
      }
    end

    it 'deletes the post' do
      expect { subject }.to change(Publication::Vote, :count).by(-1)
    end

    it 'redirects to post #index' do
      subject
      expect(response).to redirect_to post_path(pub_post)
    end
  end
end
