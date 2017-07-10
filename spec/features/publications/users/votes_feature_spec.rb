# describe 'User publication vote feature', type: :feature do
#   let!(:user) do
#     create :user,
#            name: 'Administrator',
#            email: 'admin@admin.com',
#            password: 'password'
#   end

#   let(:friend) { create :user, name: 'John', email: 'john@email.com' }

#   let!(:friends_post) do
#     create :publication_post,
#            title: 'First post',
#            content: 'good content',
#            user: friend
#   end

#   before do
#     visit new_user_session_path
#     fill_in 'user[email]', with: user.email
#     fill_in 'user[password]', with: 'password'
#     click_button 'Vhod'
#   end

#   describe '#create' do
#     before do
#       visit user_posts_path(friend)
#       click_link 'Show post'
#     end

#     context 'when voting for own comment' do
#       let!(:comment) do
#         create :publication_comment,
#           user: user,
#           post: friends_post
#       end

#       it 'redirect to post with voted comment' do
#         click_link 'Vote'
#         expect(comment.votes.count).to eq 1
#         expect(page).to have_current_path user_post_path(friend, friends_post)
#       end

#       it 'increase count of comment votes' do
#         click_link 'Vote'
#         expect(page).to have_content '1 users voted'
#       end

#       it 'changes link for vote action' do
#         click_link 'Vote'
#         expect(page).to have_link 'Unlike'
#       end
#     end

#     context "when voting for friend\'s comment" do
#       let!(:comment) do
#         create :publication_comment,
#           user: friend,
#           post: friends_post
#       end

#       it 'redirect to post with voted comment' do
#         expect(comment.votes.count).to eq 1
#         expect(page).to have_current_path user_post_path(friend, friends_post)
#       end

#       it 'increase count of comment votes' do
#         expect(page).to have_content '1 users voted'
#       end

#       it 'changes link for vote action' do
#         expect(page).to have_link 'Unlike'
#       end
#     end
#   end

#   describe '#destroy' do
#     before do
#       visit user_posts_path(friend)
#       click_link 'Show post'
#       click_link 'Unlike'
#     end

#     context 'when removing vote from own comment' do
#       let!(:comment) do
#         create :publication_comment,
#           user: user,
#           post: friends_post
#       end

#       let!(:vote) { create :publication_vote, comment: comment, user: user }

#       it 'redirect to post with voted comment' do
#         expect(comment.votes.count).to eq 0
#         expect(page).to have_current_path user_post_path(friend, friends_post)
#       end

#       it 'increase count of comment votes' do
#         expect(page).to have_content '0 users voted'
#       end

#       it 'changes link for vote action' do
#         expect(page).to have_link 'Like'
#       end
#     end

#     context "when removing vote from friend\'s comment" do
#       let!(:comment) do
#         create :publication_comment,
#               user: friend,
#               post: friends_post
#       end

#       let!(:vote) { create :publication_vote, comment: comment, user: friend }

#       it 'redirect to post with voted comment' do
#         expect(comment.votes.count).to eq 0
#         expect(page).to have_current_path user_post_path(friend, friends_post)
#       end

#       it 'increase count of comment votes' do
#         expect(page).to have_content '0 users voted'
#       end

#       it 'changes link for vote action' do
#         expect(page).to have_link 'Like'
#       end
#     end
#   end
# end
