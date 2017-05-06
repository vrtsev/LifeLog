Then(/^page should contain ([^']*) '([^']*)'/) do |obj, obj_name|
  case obj
  when 'button' then page.has_button?(obj_name)
  when 'link' then page.has_link?(obj_name)
  when 'field' then page.has_field?(obj_name)
  else
    expect(page).to have_content(obj_name)
  end
end

Then(/^page should not contain ([^']*) '([^']*)'/) do |obj, obj_name|
  case obj
  when 'button' then page.has_no_button?(obj_name)
  when 'link' then page.has_no_link?(obj_name)
  when 'field' then page.has_no_field?(obj_name)
  else
    expect(page).to have_no_content(obj_name)
  end
end

And(/^page should have field '([^']*)' filled with '([^']*)'/) do |field, content|
  expect(find_field(field).value).to eq content
end

And(/^i fill '([^']*)' field with '([^']*)'/) do |field, content|
  fill_in(field, with: content)
end