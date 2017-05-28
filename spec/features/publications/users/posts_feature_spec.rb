describe 'User publication posts feature', type: :feature do
  let!(:user)       { create :user }
  let!(:other_user) { create :user }

  let!(:first_post) do
    create :publication_post,
           title:   'First post',
           content: 'one',
           user:    user
  end

  let!(:other_post) do
    create :publication_post,
           title:   'Second post',
           content: 'two',
           user:    other_user
  end

  describe '#index' do
    context 'posts' do
      before { visit user_posts_path(user) }

      it 'displays all user posts' do
        expect(page).to have_content first_post.title
        expect(page).to have_content first_post.content

        expect(page).not_to have_content other_post.title
        expect(page).not_to have_content other_post.content
      end
    end

    context 'categories' do
      let!(:first_category) do
        create :publication_category,
               title:       'First category',
               description: 'one',
               user:        user
      end

      let!(:other_category) do
        create :publication_category,
               title:       'Second category',
               description: 'two',
               user:        other_user
      end

      before { visit user_posts_path(user) }

      it 'displays all user posts' do
        expect(page).to have_content first_category.title
        expect(page).to have_content first_category.description

        expect(page).not_to have_content other_category.title
        expect(page).not_to have_content other_category.description
      end
    end
  end

  describe '#show' do
    let!(:first_tagging)  { create :tagging, tag: sun_tag, post: first_post }
    let!(:second_tagging) { create :tagging, tag: rain_tag, post: first_post }

    let(:sun_tag)         { create :tag, name: 'first_tag' }
    let(:rain_tag)        { create :tag, name: 'second_tag' }

    let(:tags)            { first_post.tags }
    before do
      visit user_posts_path(user)
      click_link 'Show post'
    end

    it 'displays post attributes' do
      expect(page).to have_content first_post.title
      expect(page).to have_content first_post.content
    end

    it 'displays tag links' do
      expect(page).to have_link tags.first.name
      expect(page).to have_link tags.second.name
    end
  end
end
