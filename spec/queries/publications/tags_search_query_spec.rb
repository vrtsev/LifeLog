describe Publications::TagsSearchQuery do
  let(:user)       { create :user }
  let(:other_user) { create :user }
  let(:query)      { 'tag' }
  let(:conditions) { nil }

  let(:first_tag)       { create :tag, name: 'first_tag' }
  let!(:first_post)     { create :publication_post, user: user }
  let!(:first_tagging)  { create :tagging, tag: first_tag, post: first_post }

  let(:second_tag)      { create :tag, name: 'something' }
  let!(:second_post)    { create :publication_post, user: user }
  let!(:second_tagging) { create :tagging, tag: second_tag, post: second_post }

  let(:third_tag)       { create :tag, name: 'third_tag' }
  let!(:third_post)     { create :publication_post, user: user }
  let!(:third_tagging)  { create :tagging, tag: third_tag, post: third_post }

  let(:fourth_tag)      { create :tag, name: 'another' }
  let!(:fourth_post)    { create :publication_post, user: other_user }
  let!(:fourth_tagging) { create :tagging, tag: fourth_tag, post: fourth_post }

  let(:fifth_tag)       { create :tag, name: 'fifth_tag' }
  let!(:fifth_post)     { create :publication_post, user: other_user }
  let!(:fifth_tagging)  { create :tagging, tag: fifth_tag, post: fifth_post }

  let(:scope) do
    Tag.joins(:taggings).joins(:posts)
       .where(posts: { user: user, type: 'Publication::Post' })
       .distinct
  end

  subject { described_class.new(scope, query, conditions).results }

  describe '#results' do
    context 'when search query is specified' do
      let(:result_scope) { [first_tag, third_tag] }

      it { expect(subject).to eq(result_scope) }
    end

    context 'when search query is not specified' do
      let(:query)        { nil }
      let(:result_scope) { [first_tag, second_tag, third_tag] }

      it { expect(subject).to match_array(result_scope) }
    end
  end
end
