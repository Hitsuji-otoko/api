# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Article.create([
    { title: 'Article title 1', content: 'Article content 1', slug: 'article-title-1' 
     },
    { title: 'Article title 2', content: 'Article content 2', slug: 'article-title-2' 
     },
    { title: 'Article title 3', content: 'Article content 3', slug: 'article-title-3' 
     },
])