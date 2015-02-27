class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :songs
  has_many :votes, through: :songs

end

#User.songs
#
# user
# has many votes
# has many songs
#
# votes
# belogs to users and song
#
# song
# has many votes
# belongs to user
