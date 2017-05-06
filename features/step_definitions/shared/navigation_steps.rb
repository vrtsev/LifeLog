def find_path(page)
  return build_post_path(page) if page =~ /^([^']*) post page/
  return build_category_path(page) if page =~ /^([^']*) category page/
  build_common_path(page)
end

def build_common_path(page)
  case page
  when 'my profile page'   then posts_path
  when 'login page'        then new_user_session_path
  when 'home page'         then root_path
  when 'profile edit page' then edit_user_registration_path
  else page
  end
end

def build_post_path(page)
  case page
  when 'new post page'     then new_post_path
  when 'show post page'    then post_path(Post.last)
  when 'edit post page'    then edit_post_path(Post.last)
  end
end

def build_category_path(page)
  case page
  when 'new category page' then new_category_path
  when 'show category page' then posts_path(category: Category.last.id)
  when 'edit category page' then edit_category_path(Category.last)
  end
end

When(/^i visit ([^']*)/) do |page|
  visit find_path(page)
end

When(/^i'm on ([^']*)'s profile/) do |username|
  user = User.find_by name: username
  visit profile_path(user)
end

Then(/^site should redirect to ([^']*)/) do |page|
  assert_current_path find_path(page)
end

Then(/^site should redirect on ([^']*)'s post '([^']*)'/) do |username, title|
  user = User.find_by name: username
  post = Post.find_by title: title
  assert_current_path profile_post_path(user, post)
end

And(/^i click on ([^']*) '([^']*)'/) do |obj, obj_name|
  case obj
  when 'button'
    click_button(obj_name)
  else
    click_link(obj_name)
  end
end