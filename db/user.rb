class User < ActiveRecord::Base
has_one :account
has_many :post
end