# describe 'Publication search feature', type: :feature do
#   let(:query) { 'ruby' }
#   let!(:user) do
#     create :user,
#            name: 'Administrator',
#            email: 'admin@admin.com',
#            password: 'password'
#   end

#   # Tags
#   let!(:first_tag)      { create :tag, name: 'first_tag' }
#   let!(:second_tag)     { create :tag, name: 'ruby_syntax' }
#   let!(:third_tag)      { create :tag, name: 'i_am_rubyist' }

#   let!(:first_tagging)  { create :tagging, tag: first_tag, post: first_post }
#   let!(:second_tagging) { create :tagging, tag: second_tag, post: second_post }
#   let!(:third_tagging)  { create :tagging, tag: third_tag, post: third_post }

#   # Posts
#   let!(:first_post) do
#     create \
#       :publication_post,
#       user: user,
#       title: 'ruby blocks',
#       content: 'smth one'
#   end

#   let!(:second_post) do
#     create \
#       :publication_post,
#       user: user,
#       title: 'linux',
#       content: 'operating system'
#   end

#   let!(:third_post) do
#     create \
#       :publication_post,
#       user: user,
#       title: 'syntax',
#       content: 'in ruby'
#   end

#   # Comments
#   let!(:first_comment) do
#     create \
#       :publication_comment,
#       user: user,
#       post: second_post,
#       content: 'programming'
#   end

#   let!(:second_comment) do
#     create \
#       :publication_comment,
#       user: user,
#       post: second_post,
#       content: 'love ruby'
#   end

#   let!(:third_comment) do
#     create \
#       :publication_comment,
#       user: user,
#       post: second_post,
#       content: 'i am rubyist'
#   end

#   before do
#     visit new_user_session_path
#     fill_in 'user[email]', with: user.email
#     fill_in 'user[password]', with: 'password'
#     click_button 'Вход'
#   end

#   describe '#index' do
#     before do
#       visit posts_path
#       fill_in 'query', with: query
#       click_button 'Search'
#     end

#     context 'tags' do
#       it 'displays filtered tag names' do
#         expect(page).to have_content(second_tag.name)
#         expect(page).to have_content(third_tag.name)

#         expect(page).not_to have_content(first_tag.name)
#       end
#     end

#     context 'posts' do
#       it 'displays filtered posts' do
#         expect(page).to have_content(first_post.title)
#         expect(page).to have_content(third_post.title)

#         expect(page).not_to have_content(second_post.title)
#       end
#     end

#     context 'comments' do
#       it 'displays filtered comments' do
#         expect(page).to have_content(second_comment.content)
#         expect(page).to have_content(third_comment.content)

#         expect(page).not_to have_content(first_comment.content)
#       end
#     end
#   end
# end
