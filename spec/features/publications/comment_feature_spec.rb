# describe 'Publication comments feature', type: :feature do
#   let!(:first_post) { create :publication_post, user: user }
#   let!(:user) do
#     create :user,
#            name: 'Administrator',
#            email: 'admin@admin.com',
#            password: 'password'
#   end

#   let!(:first_comment) do
#     create :publication_comment,
#            content: 'first comment',
#            post: first_post,
#            user: user
#   end

#   before do
#     visit new_user_session_path
#     fill_in 'user[email]', with: user.email
#     fill_in 'user[password]', with: 'password'
#     click_button 'Вход'
#   end

#   describe 'post page with comments' do
#     before do
#       visit posts_path
#       click_link 'Show post'
#     end

#     it 'displays category attributes' do
#       expect(page).to have_content first_comment.content
#     end
#   end

#   describe '#new' do
#     before do
#       visit post_path(first_post.id)
#       click_link 'New Comment'
#     end

#     it 'displays form for new category' do
#       expect(page).to have_field 'comment[content]'
#       expect(page).to have_button 'Save'
#     end
#   end

#   describe '#create' do
#     let(:content) { 'its wonderful' }

#     context 'valid comment' do
#       before do
#         visit post_path(first_post.id)
#         click_link 'New Comment'
#         fill_in 'comment[content]', with: content
#         click_button 'Save'
#       end

#       it 'redirect to created post' do
#         expect(page).to have_current_path post_path(first_post.id)
#         expect(page).to have_content content
#       end
#     end

#     context 'invalid category' do
#       let(:invalid_content) { 'a' }

#       before do
#         visit post_path(first_post.id)
#         click_link 'New Comment'
#         fill_in 'comment[content]', with: invalid_content
#         click_button 'Save'
#       end

#       it 'displays form errors' do
#         expect(page).to have_content 'Content is too short'
#       end
#     end
#   end

#   describe '#edit' do
#     let(:content_value) { find_field('comment[content]').value }

#     before do
#       visit post_path(first_post.id)
#       click_link 'Edit comment'
#     end

#     it 'displays form for existed post' do
#       expect(content_value).to eq first_comment.content
#       expect(page).to have_button 'Save'
#     end
#   end

#   describe '#update' do
#     let(:content) { 'UPDATED' }

#     context 'valid category' do
#       before do
#         visit post_path(first_post.id)
#         click_link 'Edit comment'
#         fill_in 'comment[content]', with: content
#         click_button 'Save'
#       end

#       it 'redirect to created post' do
#         expect(page).to have_current_path post_path(first_post)
#         expect(page).to have_content content
#       end
#     end

#     context 'invalid category' do
#       let(:invalid_content) { 'a' }

#       before do
#         visit post_path(first_post)
#         click_link 'Edit comment'
#         fill_in 'comment[content]', with: invalid_content
#         click_button 'Save'
#       end

#       it 'displays form errors' do
#         expect(page).to have_content 'Content is too short'
#       end
#     end
#   end

#   describe '#destroy' do
#     before do
#       visit post_path(first_post)
#       click_link 'Destroy comment'
#     end

#     it 'redirect to created post' do
#       expect(page).to have_current_path post_path(first_post)
#       expect(page).not_to have_content first_comment.content
#     end
#   end
# end
