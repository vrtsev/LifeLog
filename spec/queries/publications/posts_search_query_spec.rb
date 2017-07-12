describe Publications::PostsSearchQuery do
  let(:user)       { create :user }
  let(:query)      { 'post' }
  let(:conditions) { nil }

  let!(:first_post) do
    create \
      :publication_post,
      title: 'First post',
      content: 'mega content',
      user: user,
      supplemented: true,
      pinned: false,
      visible: false,
      commentable: true,
      created_at: '2017-05-05 10:41:11 UTC'
  end

  let!(:second_post) do
    create \
      :publication_post,
      title: 'Second post',
      content: 'driver',
      user: user,
      supplemented: false,
      pinned: true,
      visible: true,
      commentable: false,
      created_at: '2017-05-10 06:13:11 UTC'
  end

  let!(:third_post) do
    create \
      :publication_post,
      title: 'Third post',
      content: 'super content',
      user: user,
      supplemented: true,
      pinned: true,
      visible: false,
      commentable: false,
      created_at: '2017-05-15 19:25:11 UTC'
  end

  let!(:fourth_post) do
    create \
      :publication_post,
      title: 'Fourth post',
      content: 'something',
      user: user,
      supplemented: false,
      pinned: false,
      visible: true,
      commentable: true,
      created_at: '2017-05-20 23:06:11 UTC'
  end

  let!(:other_post) do
    create \
      :publication_post,
      title: 'Something',
      content: 'does not matter',
      visible: false,
      commentable: false,
      created_at: '2017-05-31 19:25:11 UTC',
      user: user
  end

  subject { described_class.new(user, query, conditions).results }

  describe '#results' do
    context 'when search query is specified' do
      context 'when filters are applied' do
        context 'when supplemeted condition passed' do
          let(:conditions)   { { supplemented: '1' } }
          let(:result_scope) { [first_post, third_post] }

          it { expect(subject).to match_array(result_scope) }
        end

        context 'when pinned condition passed' do
          let(:conditions)   { { pinned: '1' } }
          let(:result_scope) { [second_post, third_post] }

          it { expect(subject).to match_array(result_scope) }
        end

        context 'when visible condition passed' do
          let(:conditions)   { { visible: '1' } }
          let(:result_scope) { [second_post, fourth_post] }

          it { expect(subject).to match_array(result_scope) }
        end

        context 'when commentable condition passed' do
          let(:conditions)   { { commentable: '1' } }
          let(:result_scope) { [first_post, fourth_post] }

          it { expect(subject).to match_array(result_scope) }
        end

        context 'when date condition passed' do
          let(:conditions) do
            { from_date: '2017-05-09', to_date: '2017-05-16' }
          end
          let(:result_scope) { [second_post, third_post] }

          it { expect(subject).to match_array(result_scope) }
        end
      end

      context 'when filters are not applied' do
        let(:query)        { 'er' }
        let(:result_scope) { [second_post, third_post, other_post] }

        it { expect(subject).to eq(result_scope) }
      end
    end

    context 'when search query is not specified' do
      let(:query) { nil }

      context 'when filters are applied' do
        context 'when supplemeted condition passed' do
          let(:conditions)   { { supplemented: '1' } }
          let(:result_scope) { [first_post, third_post] }

          it { expect(subject).to match_array(result_scope) }
        end

        context 'when pinned condition passed' do
          let(:conditions)   { { pinned: '1' } }
          let(:result_scope) { [second_post, third_post] }

          it { expect(subject).to match_array(result_scope) }
        end

        context 'when visible condition passed' do
          let(:conditions)   { { visible: '1' } }
          let(:result_scope) { [second_post, fourth_post] }

          it { expect(subject).to match_array(result_scope) }
        end

        context 'when commentable condition passed' do
          let(:conditions)   { { commentable: '1' } }
          let(:result_scope) { [first_post, fourth_post] }

          it { expect(subject).to match_array(result_scope) }
        end

        context 'when date condition passed' do
          let(:conditions) do
            { from_date: '2017-05-09', to_date: '2017-05-16' }
          end
          let(:result_scope) { [second_post, third_post] }

          it { expect(subject).to match_array(result_scope) }
        end
      end

      context 'when filters are not applied' do
        let(:query)        { nil }
        let(:result_scope) { Publication::Post.all }

        it { expect(subject).to match_array(result_scope) }
      end
    end
  end
end
