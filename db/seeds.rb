admin = User.create! \
  name:     'Administrator',
  status:   'Site creator',
  photo:    nil,
  email:    'admin@example.com',
  password: 'password'

michael = User.create! \
  name:     'Michael',
  status:   'forward to the dream',
  photo:    nil,
  email:    'michael@example.com',
  password: 'password'

# Tags
  ruby_tag     = Tag.create!(name: 'ruby')
  syntax_tag   = Tag.create!(name: 'syntax')
  oop_tag      = Tag.create!(name: 'oop')
  linux_tag    = Tag.create!(name: 'linux')
  terminal_tag = Tag.create!(name: 'terminal')
  env_tag      = Tag.create!(name: 'env')
  country_tag  = Tag.create!(name: 'country')
  usa_tag      = Tag.create!(name: 'usa')
  europe_tag   = Tag.create!(name: 'europe')
  oak_tag      = Tag.create!(name: 'oak')
  tree_tag     = Tag.create!(name: 'tree')
  birch_tag    = Tag.create!(name: 'birch')

# User: Administrator
ruby_category = admin.publication_categories.create! \
  title:       'Ruby',
  description: 'Programming language'

  syntax_post = admin.publication_posts.create! \
    title:    'Syntax',
    content:  'Lets write some code',
    category: ruby_category

    syntax_post.taggings.create!(tag: ruby_tag)
    syntax_post.taggings.create!(tag: syntax_tag)

    first_comment = syntax_post.comments.create! \
      content: 'ruby uses snake_case',
      user:    admin

      first_comment.votes.create!(user: michael)

    second_comment = syntax_post.comments.create! \
      content: 'and also use indentation',
      user:    michael

      # no vote

  oop_post = admin.publication_posts.create! \
    title:    'OOP',
    content:  'Inheritance, incapsulation, polymorphism',
    category: ruby_category

    oop_post.taggings.create!(tag: ruby_tag)
    oop_post.taggings.create!(tag: oop_tag)

    third_comment = oop_post.comments.create! \
      content: 'incapsulation means using private methods',
      user:    michael

      # no vote

    fourth_comment = oop_post.comments.create! \
      content: 'polymorphism means redefining methods in subcalses',
      user:    admin

      fourth_comment.votes.create!(user: michael)


linux_category = admin.publication_categories.create! \
  title:       'Linux',
  description: 'Operating system'

  terminal_post = admin.publication_posts.create! \
    title:    'Terminal',
    content:  'Most important commands',
    category: linux_category

    terminal_post.taggings.create!(tag: linux_tag)
    terminal_post.taggings.create!(tag: terminal_tag)

    fifth_comment = terminal_post.comments.create! \
      content: '$cd changes your directory',
      user:    admin

      fifth_comment.votes.create!(user: michael)

    sixth_comment = terminal_post.comments.create! \
      content: '$pwd shows your current directory',
      user:    michael

      # no vote

  variables_post = admin.publication_posts.create! \
    title:    'Env variables',
    content:  'Very usefull thing',
    category: linux_category

    variables_post.taggings.create!(tag: linux_tag)
    variables_post.taggings.create!(tag: env_tag)

    seventh_comment = variables_post.comments.create! \
      content: 'use it to store secret data',
      user:    michael

      # no vote

    eighth_comment = variables_post.comments.create! \
      content: 'it can be used in your rails app',
      user:    admin

      eighth_comment.votes.create!(user: michael)

# User: Michael
travel_category = michael.publication_categories.create! \
  title:       'Travel',
  description: 'Countries and more'

  usa_post = michael.publication_posts.create! \
    title:    'USA',
    content:  'United States of America',
    category: travel_category

    usa_post.taggings.create!(tag: country_tag)
    usa_post.taggings.create!(tag: usa_tag)

    nineth_comment = usa_post.comments.create! \
      content: 'Very big country with large population',
      user:    admin

      nineth_comment.votes.create!(user: admin)

    tenth_comment = usa_post.comments.create! \
      content: 'Yeah, thats right!',
      user:    michael

      # no vote

  europe_post = michael.publication_posts.create! \
    title:    'Europe',
    content:  'Germany, France, Italy etc..',
    category: travel_category

    europe_post.taggings.create!(tag: country_tag)
    europe_post.taggings.create!(tag: europe_tag)

    eleventh_comment = europe_post.comments.create! \
      content: 'Ukraine wants to Europe',
      user:    admin

      # no vote

    twelfth_comment = europe_post.comments.create! \
      content: 'Europe dont want to be in union with Ukraine',
      user:    michael

      twelfth_comment.votes.create!(user: admin)

nature_category = michael.publication_categories.create! \
  title:       'Nature',
  description: 'Flowers, sky'

  oak_post = michael.publication_posts.create! \
    title:    'Oak',
    content:  'Very powerfull tree :)',
    category: nature_category

    oak_post.taggings.create!(tag: country_tag)
    oak_post.taggings.create!(tag: oak_tag)

    thirteenth_comment = oak_post.comments.create! \
      content: 'Oak lives more than 200 years',
      user:    admin

      # no vote

    fourteenth_comment = oak_post.comments.create! \
      content: 'I agree with you, admin',
      user:    michael

      fourteenth_comment.votes.create!(user: admin)

  birch_post = michael.publication_posts.create! \
    title:    'Birch',
    content:  'Very beautiful tree',
    category: nature_category

    birch_post.taggings.create!(tag: tree_tag)
    birch_post.taggings.create!(tag: birch_tag)

    fifteenth_comment = birch_post.comments.create! \
      content: 'You can see many birches in Russia',
      user:    admin

      fifteenth_comment.votes.create!(user: admin)

    sixteenth_comment = birch_post.comments.create! \
      content: 'Or in Ukraine',
      user:    michael

      # no vote

