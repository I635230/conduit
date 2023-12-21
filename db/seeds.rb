# メインのサンプルユーザーを1人作成する
User.create!(username:  "sakana",
             email: "sakana@example.com",
             password:              "foobar",
             password_confirmation: "foobar")

# 追加のユーザーをまとめて生成する
9.times do |n|
  name  = Faker::Name.name.gsub(".", "")
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(username:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# タイトルの設定
titles = ["The Impact of Climate Change on Global Agriculture", 
          "Understanding the Power of Quantum Computing", 
          "Exploring the Depths of Oceanic Biodiversity", 
          "The Psychology of Decision-Making Under Uncertainty", 
          "Artificial Intelligence in Healthcare: Revolutionizing Patient Care", 
          "The Rise of Sustainable Fashion: Ethical Trends in the Industry", 
          "Unlocking the Mysteries of the Human Brain", 
          "The Future of Work: Remote Teams and Digital Collaboration", 
          "Cryptocurrency: A Comprehensive Guide to Digital Money", 
          "Renewable Energy: Innovations and Challenges", 
          "Space Exploration: New Horizons and Discoveries", 
          "The Evolution of Social Media and Its Impact on Society", 
          "Mental Health Awareness in a Digital Age", 
          "Cultural Diversity and Its Influence on Global Markets", 
          "The Intersection of Technology and Education", 
          "Cybersecurity Threats in the 21st Century", 
          "Innovative Solutions for Urban Sustainability", 
          "The Art of Storytelling: Traditional Narratives in a Modern World", 
          "Global Health Crisis: Addressing Pandemics and Preparedness", 
          "The Future of Transportation: From Autonomous Vehicles to Hyperloop", 
          "Innovations in Clean Energy Technologies", 
          "Decoding the Secrets of the Universe: Cosmology Unraveled", 
          "Entrepreneurship in the Digital Age: Strategies for Success", 
          "Mental Resilience: Navigating Life's Challenges", 
          "Robotics Revolution: Transforming Industries and Daily Life", 
          "Exploring Cultural Heritage Preservation in the Modern Era", 
          "The Future of Food: Sustainable Production and Consumption", 
          "Ethics in Artificial Intelligence Development", 
          "The Psychology of Creativity and Innovation", 
          "Wildlife Conservation in a Changing Climate", 
          "Advancements in Personalized Medicine", 
          "The Impact of Social Media on Mental Well-being", 
          "Quantum Physics: Bridging Science and Technology", 
          "Adapting to Remote Work Culture: Challenges and Solutions", 
          "Neuroplasticity: Harnessing the Brain's Adaptive Power", 
          "Urbanization and Its Effects on Global Societies", 
          "The Role of Big Data in Shaping Industries", 
          "The Quest for Renewable Resources: Balancing Needs and Sustainability", 
          "Future Trends in Virtual Reality and Augmented Reality", 
          "The Intersection of Art and Technology: Digital Creativity", 
          "The Evolution of E-commerce: Trends and Transformations", 
          "Climate Crisis Mitigation: Global Efforts and Challenges", 
          "Innovations in Sustainable Architecture and Design", 
          "Artificial Intelligence Ethics: Balancing Innovation and Responsibility", 
          "Exploring the Microbiome: Key Insights into Human Health", 
          "Cybersecurity in a Hyperconnected World", 
          "Education Reform in the 21st Century: Adapting to Change", 
          "The Psychology of Habits and Behavioral Change", 
          "The Future of Privacy in a Data-Driven Society", 
          "Reimagining Urban Spaces for Community Well-being", 
          "Quantum Computing Applications Beyond Cryptography", 
          "Indigenous Knowledge and Its Relevance in Modern Society", 
          "The Resurgence of Traditional Crafts in a Digital Age", 
          "The Impact of Automation on the Job Market", 
          "Beyond Earth: Colonizing Mars and Space Exploration", 
          "Building Resilient Cities: Infrastructure for the Future", 
          "Mental Health Advocacy: Breaking Stigmas, Promoting Wellness", 
          "The Intersection of AI and Creativity: Artistic Frontiers", 
          "Sustainable Agriculture: Farming for the Future", 
          "Redefining Work-Life Balance in a Remote Era", 
          "Generalization of Bell-CHSH Inequality with Measurement Dependence"]

# 20記事
users = User.order(:created_at).take(3)
20.times do |i|
  users.each.with_index(1) do |user, j|
    title = titles[j+users.length*i]
    user.articles.create!(title: title, slug: title.gsub(" ", "-"), 
                          description: Faker::Lorem.sentence(word_count: 12) , content: Faker::Lorem.sentence(word_count: 100))
  end
end