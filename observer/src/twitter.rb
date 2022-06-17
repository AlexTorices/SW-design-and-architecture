# Observer Pattern
# Date: 10-Mar-2022
# Authors:
#          A01377744 Alejandro Torices Oliva
#          A01376544 Mariana Paola Caballero Cabrera
# File name: twitter.rb

# Module that handles the followers of a twitter account
module Account
    def initialize()
        @followers = []
    end

    # Adds a new follower to the followers array
    def add_follower(user)
        @followers << user
    end
end

# Models a twitter user, with a name and an array of followers
class Twitter
    include Account

    # The instance variable <em>name</em> should be readable
    attr_reader :name
    def initialize(name)
        super()     # Initialize <em>Account</em> module
        @name = name
    end

    # The current user becomes a new follower of the target user
    def follow(user)
        user.add_follower self
        self
    end

    # For each follower, prints the tweet including both user names
    def tweet(text)
        @followers.each do |follower|
            puts(follower.name + ' received a tweet from ' + @name + ': ' + text)
        end
    end
end

