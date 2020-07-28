class User < ActiveRecord::Base
    has_secure_password
    has_many :logs
    has_one :goal

    def slug
        self.username.downcase.gsub(" ", "-")
      end
    
      def self.find_by_slug(slug)
        self.all.find do |obj|
            obj.slug == slug
        end
      end
      
end