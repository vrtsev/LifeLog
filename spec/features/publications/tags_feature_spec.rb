describe 'Publication tags feature', type: :feature do
  let!(:user) do
    create :user,
           name: 'Administrator',
           email: 'admin@admin.com',
           password: 'password'
  end

  let(:first_post)  { create :publication_post, user: user, title: 'First' }
  let(:second_post) { create :publication_post, user: user, title: 'Second' }
  let(:third_post)  { create :publication_post, user: user, title: 'Third' }

  let(:first_tag)   { create :tag, name: 'first_tag' }
  let(:second_tag)  { create :tag, name: 'second_tag' }

  let!(:first_tagging)  { create :tagging, tag: first_tag, post: first_post }
  let!(:second_tagging) { create :tagging, tag: first_tag, post: second_post }
  let!(:third_tagging)  { create :tagging, tag: second_tag, post: third_post }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'password'
    click_button 'Вход'
  end

  describe '#show' do
    let(:choosen_tag) { first_tag.name }
    before do
      visit post_path(first_post)
      click_link choosen_tag
    end

    it 'has named url path' do
      expect(page).to have_current_path(tag_path(choosen_tag))
    end

    it 'displays posts with choosen tag' do
      expect(page).to have_content first_post.title
      expect(page).to have_content second_post.title
    end

    it 'does not displays posts with another tags' do
      expect(page).not_to have_content third_post.title
    end
  end
end
