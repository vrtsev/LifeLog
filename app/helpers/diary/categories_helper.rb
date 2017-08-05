module Diary::CategoriesHelper
  def define_active_category(category)
    'active' if current_page?(diary_category_path(category))
  end
end
