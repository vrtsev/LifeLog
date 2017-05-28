describe 'Users feature', type: :feature do
  let!(:first_user)  { create :user, name: 'Admin' }
  let!(:second_user) { create :user, name: 'User' }

  before do
    visit root_path
    click_link 'All users'
  end

  describe '#index' do
    it 'shows page title' do
      expect(page).to have_content('All users')
    end

    it 'shows all registered users' do
      expect(page).to have_content(first_user.name)
      expect(page).to have_content(first_user.email)

      expect(page).to have_content(second_user.name)
      expect(page).to have_content(second_user.email)
    end
  end

  describe '#show' do
    before do
      click_link "Show profile of #{first_user.name}"
    end

    it 'redirects to user posts url' do
      expect(page).to have_current_path(user_posts_path(first_user))
    end
  end
end
