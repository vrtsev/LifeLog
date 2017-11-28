module Publications::Post::Cell
  class IndexPostBlock < Trailblazer::Cell
    include ActionView::RecordIdentifier
    include ActionView::Helpers::FormOptionsHelper
    include TruncateHtmlHelper

    property :title
    property :pinned
    property :supplemented
    property :supplemented_at
    property :content
    property :visible
    property :created_at

    def show
      render
    end

    private

    def state_labels
      labels = ""
      labels << "<span class='label success'>Обновлено</span>" if supplemented
      labels << "<span class='label blue-grey'>Скрыт</span>" unless visible

      labels.html_safe
    end

    def timestamps
      html = created_at.strftime("%d.%m.%Y в %I:%M")
      html << " (Обновлено #{supplemented_at.strftime("%d.%m.%Y в %I:%M")})" if supplemented

      html.html_safe
    end

    def post_content
      truncate_html(content, length: 400)
    end

    def post_tags
      return unless model.tags.present?

      model.tags.inject('') do |string, tag|
        string << (link_to "##{tag.name}", tag_path(tag.name), class: "label")
      end.html_safe
    end

    def pin_indicator
      return unless pinned

      "<i class='fa fa-thumb-tack'></i>".html_safe
    end

    # Classes
    def visibility_class
      'post-hidden' unless visible
    end

    def pinned_state_class
       pinned ? 'pinned-post-header' : 'dker'
    end

    # Links
    def show_post_link
      link_to title, post_path(model)
    end

    def edit_link
      link_to 'Редактировать', edit_post_path(model), class: 'dropdown-item'
    end

    def delete_link
      link_to 'Удалить', post_path(model), method: :delete, class: 'dropdown-item', data: { confirm: 'Are you sure?' }
    end
  end
end