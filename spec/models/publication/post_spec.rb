# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  title           :string
#  content         :text
#  supplemented    :boolean          default("false")
#  supplemented_at :datetime
#  pinned          :boolean          default("false")
#  visible         :boolean          default("true")
#  commentable     :boolean          default("true")
#  user_id         :integer          not null
#  category_id     :integer
#  type            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

describe Publication::Post, type: :model do
  subject    { described_class.new }
  let(:user) { create :user }

  describe 'Associations' do
    let(:post)           { create :publication_post }
    let(:first_comment)  { create :publication_comment, post: post }
    let(:second_comment) { create :publication_comment, post: post }

    it 'belongs to category' do
      expect(
        described_class.reflect_on_association(:category).macro
      ).to eq :belongs_to
    end

    it 'has many comments' do
      expect(
        described_class.reflect_on_association(:comments).macro
      ).to eq :has_many
    end

    it 'deletes all nested comments if the post is deleted' do
      expect(post.comments).to match_array([first_comment, second_comment])

      expect { post.destroy }.to change { Publication::Comment.count }.by(-2)
    end
  end

  describe 'Validations' do
    subject do
      described_class.new(attributes_for(:publication_post, user_id: user.id))
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Scopes' do
    describe '.supplemented' do
      let(:suppl_post)   { create :publication_post, supplemented: true }
      let(:unsuppl_post) { create :publication_post, supplemented: false }

      it do
        expect(described_class.supplemented).to include(suppl_post)
      end

      it do
        expect(described_class.supplemented).not_to include(unsuppl_post)
      end
    end

    describe '.pinned' do
      let(:pinned_post)   { create :publication_post, pinned: true }
      let(:unpinned_post) { create :publication_post, pinned: false }

      it do
        expect(described_class.pinned).to include(pinned_post)
      end

      it do
        expect(described_class.pinned).not_to include(unpinned_post)
      end
    end

    describe '.visible' do
      let(:visible_post)   { create :publication_post, visible: true }
      let(:invisible_post) { create :publication_post, visible: false }

      it do
        expect(described_class.visible).to include(visible_post)
      end

      it do
        expect(described_class.visible).not_to include(invisible_post)
      end
    end

    describe '.commentable' do
      let(:commentable_post)   { create :publication_post, commentable: true }
      let(:uncommentable_post) { create :publication_post, commentable: false }

      it do
        expect(described_class.commentable).to include(commentable_post)
      end

      it do
        expect(described_class.commentable).not_to include(uncommentable_post)
      end
    end
  end
end
