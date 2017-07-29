# describe 'User publication post comments feature', type: :feature do
#   let!(:admin)        { create :user, name: 'Admin' }
#   let!(:user)         { create :user, name: 'David' }
#   let!(:user_post)    { create :publication_post, user: user }
#   let!(:post_comment) do
#     create \
#       :publication_comment,
#       user: admin,
#       post: user_post
#   end

#   before do
#     visit new_user_session_path
#     fill_in 'user[email]', with: admin.email
#     fill_in 'user[password]', with: 'password'
#     click_button 'Вход'
#     visit user_post_path(user, user_post)
#   end

#   describe '#new' do
#     before { click_link 'New Comment' }

#     it 'displays form for new category' do
#       expect(page).to have_field 'comment[content]'
#       expect(page).to have_button 'Save'
#     end
#   end

#   describe '#create' do
#     before do
#       click_link 'New Comment'
#       fill_in 'comment[content]', with: content
#       click_button 'Save'
#     end

#     context 'valid comment' do
#       let(:content) { 'its wonderful' }

#       it 'redirect to created post' do
#         expect(page).to have_current_path user_post_path(user, user_post)
#         expect(page).to have_content content
#       end
#     end

#     context 'invalid category' do
#       let(:content) { 'a' } # invalid content

#       it 'displays form errors' do
#         expect(page).to have_content 'Content is too short'
#       end
#     end
#   end

#   describe '#edit' do
#     let(:content_value) { find_field('comment[content]').value }
#     before              { click_link 'Edit comment' }

#     it 'displays form for existed post' do
#       expect(content_value).to eq post_comment.content
#       expect(page).to have_button 'Save'
#     end
#   end

#   describe '#update' do
#     let(:content) { 'UPDATED' }
#     before do
#       click_link 'Edit comment'
#       fill_in 'comment[content]', with: content
#       click_button 'Save'
#     end

#     context 'valid category' do
#       it 'redirect to created post' do
#         expect(page).to have_current_path user_post_path(user, user_post)
#         expect(page).to have_content content
#       end
#     end

#     context 'invalid category' do
#       let(:content) { 'a' } # invalid content

#       it 'displays form errors' do
#         expect(page).to have_content 'Content is too short'
#       end
#     end
#   end

#   describe '#destroy' do
#     before { click_link 'Destroy comment' }

#     it 'redirect to created post' do
#       expect(page).to have_current_path user_post_path(user, user_post)
#       expect(page).not_to have_content post_comment.content
#     end
#   end
# end
