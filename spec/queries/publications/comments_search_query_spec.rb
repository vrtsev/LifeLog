describe Publications::CommentsSearchQuery do
  let(:user)         { create :user }
  let(:query)        { 'comment' }
  let(:conditions)   { nil }

  let!(:first_post)  { create :publication_post, user: user }
  let!(:second_post) { create :publication_post, user: user }

  let!(:first_comment) do
    create \
      :publication_comment,
      content: 'First comment',
      created_at: '2017-05-05 10:41:11 UTC',
      post: first_post, user: user
  end

  let!(:second_comment) do
    create \
      :publication_comment,
      content: 'Second comment',
      created_at: '2017-05-10 06:13:11 UTC',
      post: first_post,
      user: user
  end

  let!(:third_comment) do
    create \
      :publication_comment,
      content: 'Something else',
      created_at: '2017-05-15 19:25:11 UTC',
      post: second_post,
      user: user
  end

  let!(:fourth_comment) do
    create \
      :publication_comment,
      content: 'Not the same',
      created_at: '2017-05-20 23:06:11 UTC',
      post: second_post,
      user: user
  end

  subject { described_class.new(user, query, conditions).results }

  describe '#results' do
    context 'when search query is specified' do
      context 'when filters are applied' do
        context 'when date condition passed' do
          let(:conditions) do
            { from_date: '2017-05-09', to_date: '2017-05-16' }
          end
          let(:result_scope) { [second_comment] }

          it { expect(subject).to match_array(result_scope) }
        end
      end

      context 'when filters are not applied' do
        let(:result_scope) { [first_comment, second_comment] }

        it { expect(subject).to eq(result_scope) }
      end
    end

    context 'when search query is not specified' do
      let(:query) { nil }

      context 'when filters are applied' do
        context 'when date condition passed' do
          let(:conditions) do
            { from_date: '2017-05-09', to_date: '2017-05-16' }
          end
          let(:result_scope) { [second_comment, third_comment] }

          it { expect(subject).to match_array(result_scope) }
        end
      end

      context 'when filters are not applied' do
        let(:query)        { nil }
        let(:result_scope) { Publication::Comment.all }

        it { expect(subject).to match_array(result_scope) }
      end
    end
  end
end
