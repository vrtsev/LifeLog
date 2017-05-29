describe 'User publication posts feature', type: :feature do
  let!(:user) { create :user }

  # Categories
  let!(:category) do
    create :publication_category,
           title:       'First category',
           description: 'first descr',
           color:        2,
           user:         user
  end

  let!(:second_category) do
    create :publication_category,
           title:       'Second category',
           description: 'second_descr',
           color:        2,
           user:         user
  end

  # Posts
  let!(:first_post) do
    create :publication_post,
           title:    'First post',
           content:  'one',
           category: category,
           user:     user
  end

  let!(:second_post) do
    create :publication_post,
           title:    'Second post',
           content:  'two',
           category: category,
           user:     user
  end

  let!(:other_post) do
    create :publication_post,
           title:    'Other post',
           content:  'other',
           category: second_category,
           user:     user
  end

  describe '#show' do
    before { visit user_category_path(user, category) }

    it 'displays category info' do
      expect(page).to have_content category.title
      expect(page).to have_content category.description
    end

    it 'displays category posts' do
      expect(page).to have_content(first_post.title)
      expect(page).to have_content(second_post.title)

      expect(page).not_to have_content(other_post.title)
    end
  end
end
