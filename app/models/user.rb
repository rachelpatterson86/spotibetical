class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :votes
  has_many :songs, through: :votes

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
