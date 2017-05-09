describe 'Categories feature', type: :feature do
  let!(:user) do
    create :user,
           name: 'Administrator',
           email: 'admin@admin.com',
           password: 'password'
  end

  let!(:first_category) do
    create :publication_category,
           title: 'Trips',
           description: 'best moments',
           user: user
  end

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'password'
    click_button 'Вход'
  end

  describe '#show' do
    before do
      visit posts_path
      click_link 'Show category'
    end

    it 'displays category attributes' do
      expect(page).to have_content first_category.title
      expect(page).to have_content first_category.description
    end
  end

  describe '#new' do
    before do
      visit posts_path
      click_link 'New Category'
    end

    it 'displays form for new category' do
      expect(page).to have_field 'category[title]'
      expect(page).to have_field 'category[description]'
      expect(page).to have_button 'Save'
    end
  end

  describe '#create' do
    let(:title)       { 'Pets' }
    let(:description) { 'my home pets' }

    context 'valid category' do
      before do
        visit posts_path
        click_link 'New Category'
        fill_in 'category[title]',       with: title
        fill_in 'category[description]', with: description
        click_button 'Save'
      end

      it 'redirect to created post' do
        expect(page).to have_current_path category_path(Category.last)
        expect(page).to have_content title
        expect(page).to have_content description
      end
    end

    context 'invalid category' do
      let(:invalid_title)       { '' }
      let(:invalid_description) { 'a' }

      before do
        visit posts_path
        click_link 'New Category'
        fill_in 'category[title]',       with: invalid_title
        fill_in 'category[description]', with: invalid_description
        click_button 'Save'
      end

      it 'displays form errors' do
        expect(page).to have_content 'Description is too short'
        expect(page).to have_content 'Title can\'t be blank'
      end
    end
  end

  describe '#edit' do
    let(:title_value)       { find_field('category[title]').value }
    let(:description_value) { find_field('category[description]').value }

    before do
      visit posts_path
      click_link 'Edit category'
    end

    it 'displays form for existed post' do
      expect(title_value).to eq first_category.title
      expect(description_value).to eq first_category.description
      expect(page).to have_button 'Save'
    end
  end

  describe '#update' do
    let(:title)       { 'UPDATED' }
    let(:description) { 'Fresh content' }

    context 'valid category' do
      before do
        visit posts_path
        click_link 'Edit category'
        fill_in 'category[title]',       with: title
        fill_in 'category[description]', with: description
        click_button 'Save'
      end

      it 'redirect to created post' do
        expect(page).to have_current_path category_path(first_category)
        expect(page).to have_content title
        expect(page).to have_content description
      end
    end

    context 'invalid category' do
      let(:invalid_title)       { '' }
      let(:invalid_description) { 'a' }

      before do
        visit posts_path
        click_link 'Edit category'
        fill_in 'category[title]',       with: invalid_title
        fill_in 'category[description]', with: invalid_description
        click_button 'Save'
      end

      it 'displays form errors' do
        expect(page).to have_content 'Description is too short'
        expect(page).to have_content 'Title can\'t be blank'
      end
    end
  end

  describe '#destroy' do
    before do
      visit posts_path
      click_link 'Destroy category'
    end

    it 'redirect to created post' do
      expect(page).to have_current_path posts_path
      expect(page).not_to have_content first_category.title
      expect(page).not_to have_content first_category.description
    end
  end
end
