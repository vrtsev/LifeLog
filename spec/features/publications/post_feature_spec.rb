describe 'Publication posting feature', type: :feature do
  let!(:first_tagging)  { create :tagging, tag: sun_tag, post: first_post }
  let!(:second_tagging) { create :tagging, tag: rain_tag, post: first_post }

  let(:sun_tag)  { create :tag, name: 'first_tag' }
  let(:rain_tag) { create :tag, name: 'second_tag' }

  let!(:user) do
    create :user,
           name: 'Administrator',
           email: 'admin@admin.com',
           password: 'password'
  end

  let!(:first_post) do
    create :publication_post,
           title: 'First post',
           content: 'good content',
           user: user
  end

  let!(:first_category) do
    create :publication_category,
           title: 'First category',
           description: 'one',
           user: user
  end

  let!(:second_category) do
    create :publication_category,
           title: 'Second category',
           description: 'two',
           user: user
  end

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'password'
    click_button 'Вход'
  end

  describe '#index' do
    context 'posts' do
      let!(:second_post) do
        create :publication_post,
               title: 'Second post',
               content: 'two',
               user: user
      end

      before { visit posts_path }

      it 'displays all user posts' do
        expect(page).to have_content first_post.title
        expect(page).to have_content first_post.content

        expect(page).to have_content second_post.title
        expect(page).to have_content second_post.content
      end
    end

    context 'categories' do
      before { visit posts_path }

      it 'displays all user posts' do
        expect(page).to have_content first_category.title
        expect(page).to have_content first_category.description

        expect(page).to have_content second_category.title
        expect(page).to have_content second_category.description
      end
    end
  end

  describe '#show' do
    let(:tags) { first_post.tags }
    before { visit post_path(first_post.id) }

    it 'displays post attributes' do
      expect(page).to have_content first_post.title
      expect(page).to have_content first_post.content
    end

    it 'displays tag links' do
      expect(page).to have_link tags.first.name
      expect(page).to have_link tags.second.name
    end
  end

  describe '#new' do
    before do
      visit posts_path
      click_link 'New Post'
    end

    it 'displays form for new post' do
      expect(page).to have_field 'post[title]'
      expect(page).to have_field 'post[content]'
      expect(page).to have_field 'post[all_tags]'
      expect(page).to have_button 'Save'
    end
  end

  describe '#create' do
    let(:title)       { 'Capybara post' }
    let(:content)     { 'Some content' }
    let(:first_tag)   { 'sun' }
    let(:second_tag)  { 'rain' }
    let(:category_id) { '1' }
    context 'valid post' do
      before do
        visit posts_path
        click_link 'New Post'
        fill_in 'post[title]',       with: title
        fill_in 'post[content]',     with: content
        fill_in 'post[all_tags]',    with: "#{first_tag}, #{second_tag}"
        select first_category.title, from: 'post[category_id]'
        click_button 'Save'
      end

      it 'redirect to created post' do
        expect(page).to have_current_path post_path(Post.last)
      end

      it 'sets atributes in created post' do
        expect(page).to have_content title
        expect(page).to have_content content
      end

      it 'creates links for each post tag' do
        expect(page).to have_link first_tag
        expect(page).to have_link second_tag
      end
    end

    context 'invalid post' do
      let(:invalid_content) { 'a' }

      before do
        visit posts_path
        click_link 'New Post'
        fill_in 'post[content]', with: invalid_content
        click_button 'Save'
      end

      it 'displays form errors' do
        expect(page).to have_content 'Content is too short'
        expect(page).to have_content 'Title can\'t be blank'
      end
    end
  end

  describe '#edit' do
    let(:title_value)   { find_field('post[title]').value }
    let(:content_value) { find_field('post[content]').value }
    let(:all_tags)      { find_field('post[all_tags]').value }

    before do
      visit posts_path
      click_link 'Edit post'
    end

    it 'displays form for existed post' do
      expect(title_value).to eq first_post.title
      expect(content_value).to eq first_post.content
      expect(all_tags).to eq first_post.all_tags
      expect(page).to have_button 'Save'
    end
  end

  describe '#update' do
    let(:title)       { 'UPDATED' }
    let(:content)     { 'Fresh content' }
    let(:first_tag)   { 'cat' }
    let(:second_tag)  { 'dog' }
    let(:third_tag)   { 'fish' }
    let(:all_tags)    { "#{first_tag}, #{second_tag}, #{third_tag}" }
    let(:category_id) { '2' }

    context 'valid post' do
      before do
        visit posts_path
        click_link 'Edit post'
        fill_in 'post[title]',       with: title
        fill_in 'post[content]',     with: content
        fill_in 'post[all_tags]',    with: all_tags
        select first_category.title, from: 'post[category_id]'
        click_button 'Save'
      end

      it 'redirect to created post' do
        expect(page).to have_current_path post_path(first_post)
        expect(page).to have_content title
        expect(page).to have_content content

        expect(page).to have_link first_tag
        expect(page).to have_link second_tag
        expect(page).to have_link second_tag
      end
    end

    context 'invalid post' do
      let(:invalid_title)   { '' }
      let(:invalid_content) { 'a' }

      before do
        visit posts_path
        click_link 'Edit post'
        fill_in 'post[title]',       with: invalid_title
        fill_in 'post[content]',     with: invalid_content
        click_button 'Save'
      end

      it 'displays form errors' do
        expect(page).to have_content 'Content is too short'
        expect(page).to have_content 'Title can\'t be blank'
      end
    end
  end

  describe '#destroy' do
    before do
      visit posts_path
      click_link 'Destroy post'
    end

    it 'redirect to created post' do
      expect(page).to have_current_path posts_path
      expect(page).not_to have_content first_post.title
      expect(page).not_to have_content first_post.content
    end
  end
end
