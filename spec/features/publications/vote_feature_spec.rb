# describe 'Publication vote feature', type: :feature do
#   let!(:user) do
#     create :user,
#            name: 'Administrator',
#            email: 'admin@admin.com',
#            password: 'password'
#   end

#   let!(:first_post) do
#     create :publication_post,
#            title: 'First post',
#            content: 'good content',
#            user: user
#   end

#   let!(:post_comment) do
#     create :publication_comment,
#            user: user,
#            post: first_post
#   end

#   before do
#     visit new_user_session_path
#     fill_in 'user[email]', with: user.email
#     fill_in 'user[password]', with: 'password'
#     click_button 'Вход'
#   end

#   describe '#create' do
#     before do
#       visit posts_path
#       click_link 'Show post'
#       click_link 'Vote'
#     end

#     it 'redirect to post with voted comment' do
#       expect(page).to have_current_path post_path(first_post)
#       expect(page).to have_link 'Unlike'
#       expect(page).to have_content '1 users voted'
#     end
#   end

#   describe '#destroy' do
#     let!(:vote) { create :publication_vote, comment: post_comment, user: user }

#     before do
#       visit posts_path
#       click_link 'Show post'
#       click_link 'Unlike'
#     end

#     it 'redirect to created post' do
#       expect(page).to have_current_path post_path(first_post)
#       expect(page).to have_link 'Vote'
#       expect(page).to have_content '0 users voted'
#     end
#   end
# end
